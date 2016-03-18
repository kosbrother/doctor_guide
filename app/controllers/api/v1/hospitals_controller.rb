class Api::V1::HospitalsController < Api::ApiController

  def by_area
    area_id = params[:area_id]
    latitude = params[:latitude]
    longitude = params[:longitude]
    order = params[:order]

    if order == 'distance'
      hopitals = Hospital.where("area_id = #{area_id}").select("id,name,address,grade,latitude,longitude,comment_num,recommend_num,avg").by_distance(:origin => [latitude,longitude]).paginate(:page => params[:page], :per_page => 10)
    else
      hopitals = Hospital.where("area_id = #{area_id}").select('id,name,address,grade,latitude,longitude,comment_num,recommend_num,avg').order("#{order} desc").paginate(:page => params[:page], :per_page => 10)
    end
    render :json => hopitals
  end

  def by_area_category
    area_id = params[:area_id]
    category_id = params[:category_id]
    latitude = params[:latitude]
    longitude = params[:longitude]
    order = params[:order]

    divs = Division.joins(:div_hosp_doc_ships).where("divisions.category_id = #{category_id}").select('hospital_id').uniq{|x| x.hospital_id}
    hosp_ids = divs.map{|item| item["hospital_id"].to_i}.join(",")
    if order == 'distance'
      hopitals = Hospital.where("id in (#{hosp_ids}) and area_id = #{area_id}").select("id,name,address,grade,latitude,longitude,comment_num,recommend_num,avg").by_distance(:origin => [latitude,longitude]).paginate(:page => params[:page], :per_page => 10)
    else
      hopitals = Hospital.where("id in (#{hosp_ids}) and area_id = #{area_id}").select('id,name,address,grade,latitude,longitude,comment_num,recommend_num,avg').order("#{order} desc").paginate(:page => params[:page], :per_page => 10)
    end
    render :json => hopitals
  end

  def show
    hospital = Hospital.find(params[:id]).as_json(only: [:id,:name,:phone,:address,:grade,:assess,:ss,:cHours,:recommend_num,:comment_num,:avg])
    divisions = DivHospDocShip.joins(:hospital,:division).where("div_hosp_doc_ships.hospital_id = #{params[:id]} and doctor_id is not null").select("DISTINCT(divisions.id), divisions.id,divisions.name,divisions.category_id,hospitals.id as hospital_id, hospitals.name as hospital_name, hospitals.grade as hospital_grade")
    divisions = DivHospDocShip.joins(:hospital,:division).where("div_hosp_doc_ships.hospital_id = #{params[:id]}").select("DISTINCT(divisions.id), divisions.id,divisions.name,divisions.category_id,hospitals.id as hospital_id, hospitals.name as hospital_name, hospitals.grade as hospital_grade") if divisions.length == 0
    ds = []
    divisions.each do |d|
      d_json = d.as_json
      div = Division.find(d.id)
      d_json["avg"] = div.avg_score(params[:id])
      ds.push(d_json)
    end

    hospital[:divisions] = ds

    render :json => hospital
  end

  def score
    hospital = Hospital.find(params[:id]).as_json(only: [:id,:name,:recommend_num,:comment_num,:avg])
    render :json => hospital
  end

  def divisions_with_doctors
    ships = DivHospDocShip.joins(:doctor,:division).where("div_hosp_doc_ships.hospital_id = #{params[:id]} and doctor_id is not null").select('
      divisions.id, divisions.name, doctors.id as doctor_id, doctors.name as doctor_name
      ')
    divisions = parse_division_with_doctor_json ships
    
    if divisions.length == 0
      ships = DivHospDocShip.joins(:division).where("div_hosp_doc_ships.hospital_id = #{params[:id]}").select('divisions.id, divisions.name')
      render :json => ships
    else
      render :json => divisions
    end
  end
  
  private

  def parse_division_with_doctor_json ships
    divisions = []
    groups = ships.group_by{|x| x.id }
    groups.each do |key,array|
      division = {}
      division[:id] = key
      division[:name] = array.first.name
      doctors = []
      array.each do |v|
        doctor = {}
        doctor[:id] = v.doctor_id
        doctor[:name] = v.doctor_name
        doctors.push(doctor)
      end
      division[:doctors] = doctors
      divisions.push(division)
    end
    divisions
  end
end
