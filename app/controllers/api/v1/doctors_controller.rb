class Api::V1::DoctorsController < Api::ApiController

  def by_area_category
    area_id = params[:area_id]
    category_id = params[:category_id]

    divs = Division.joins(:div_hosp_doc_ships).where("divisions.category_id = #{category_id}").select('doctor_id').uniq{|x| x.doctor_id}
    doc_ids = divs.map{|item| item["doctor_id"].to_i}.join(",")
    doctors = Doctor.joins(:hospitals).where("doctors.id in (#{doc_ids}) and doctors.area_id = #{area_id}").select('doctors.id,doctors.name,hospitals.name as hospital').uniq{|x| x.doctor_id}

    render :json => doctors
  end

  def by_hospital_division
    hospital_id = params[:hospital_id]
    division_id = params[:division_id]

    doctors = Doctor.joins(:div_hosp_doc_ships).where("hospital_id = #{hospital_id} and division_id = #{division_id}").select('doctors.id,doctors.name').uniq{|x| x.doctor_id}

    render :json => doctors
  end
end
