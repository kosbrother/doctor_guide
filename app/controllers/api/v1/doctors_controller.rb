class Api::V1::DoctorsController < Api::ApiController

  def by_area_category
    area_id = params[:area_id]
    category_id = params[:category_id]
    latitude = params[:latitude]
    longitude = params[:longitude]
    order = params[:order]

    divs = Division.joins(:div_hosp_doc_ships).where("divisions.category_id = #{category_id}").select('doctor_id').uniq{|x| x.doctor_id}
    doc_ids = divs.map{|item| item["doctor_id"].to_i}.join(",")
    if order == 'distance'
      doctors = Doctor.joins(:hospitals).where("doctors.id in (#{doc_ids}) and doctors.area_id = #{area_id}").select("doctors.id,doctors.name,hospitals.name as hospital,doctors.latitude,doctors.longitude,doctors.comment_num,doctors.recommend_num,doctors.avg").uniq{|x| x.doctor_id}.by_distance(:origin => [latitude,longitude]).paginate(:page => params[:page], :per_page => 10)
    else
      doctors = Doctor.joins(:hospitals).where("doctors.id in (#{doc_ids}) and doctors.area_id = #{area_id}").select('doctors.id,doctors.name,hospitals.name as hospital,doctors.latitude,doctors.longitude,doctors.comment_num,doctors.recommend_num,doctors.avg').uniq{|x| x.doctor_id}.order("#{order} desc").paginate(:page => params[:page], :per_page => 10)
    end
    render :json => doctors
  end

  def by_hospital_division
    hospital_id = params[:hospital_id]
    division_id = params[:division_id]

    doctors = Doctor.joins(:div_hosp_doc_ships).where("hospital_id = #{hospital_id} and division_id = #{division_id}").select('doctors.id,doctors.name,doctors.address,doctors.comment_num,doctors.recommend_num,doctors.avg').uniq{|x| x.doctor_id}

    render :json => doctors
  end

  def show
    doctor = Doctor.find(params[:id]).as_json(only: [:id,:name,:address,:exp,:spe])
    divisions = DivHospDocShip.where("div_hosp_doc_ships.doctor_id = #{params[:id]}").uniq{|x| x.division_id}.as_json(only:[],include:{ 
      hospital: {only: [:id, :name, :address,:grade]},
      division: {only: [:id, :name]}
      })
    divs = []
    divisions.each do |div|
      d = {}
      d[:id] = div["division"]["id"]
      d[:name] = div["division"]["name"]
      d[:hospital_id] = div["hospital"]["id"]
      d[:hospital_name] = div["hospital"]["name"]
      d[:hospital_grade] = div["hospital"]["grade"]
      divs << d
    end
    doctor[:divisions] = divs
    render :json => doctor
  end

  def score
    doctor = Doctor.find(params[:id])
    d_json = doctor.as_json(only: [:id,:name,:comment_num,:recommend_num,:avg])
    d_json[:avg_friendly] = doctor.avg_friendly
    d_json[:avg_speciality] = doctor.avg_speciality
    render :json => d_json
  end
end
