class Api::V1::HospitalsController < Api::ApiController

  def by_area_category
    area_id = params[:area_id]
    category_id = params[:category_id]

    divs = Division.joins(:div_hosp_doc_ships).where("divisions.category_id = #{category_id}").select('hospital_id').uniq{|x| x.hospital_id}
    hosp_ids = divs.map{|item| item["hospital_id"].to_i}.join(",")
    hopitals = Hospital.where("id in (#{hosp_ids}) and area_id = #{area_id}").select('id,name,address,grade').paginate(:page => params[:page], :per_page => 5)

    render :json => hopitals
  end

  def show
    hospital = Hospital.find(params[:id]).as_json(only: [:id,:name,:phone,:address,:grade,:assess,:ss,:cHours])
    divisions = DivHospDocShip.joins(:hospital,:division).where("div_hosp_doc_ships.hospital_id = #{params[:id]} and doctor_id is not null").select("DISTINCT(divisions.id), divisions.id,divisions.name,divisions.category_id,hospitals.id as hospital_id, hospitals.name as hospital_name, hospitals.grade as hospital_grade")
    divisions = DivHospDocShip.joins(:hospital,:division).where("div_hosp_doc_ships.hospital_id = #{params[:id]}").select("DISTINCT(divisions.id), divisions.id,divisions.name,divisions.category_id,hospitals.id as hospital_id, hospitals.name as hospital_name, hospitals.grade as hospital_grade") if divisions.length == 0
    hospital[:divisions] = divisions
    render :json => hospital
  end
end
