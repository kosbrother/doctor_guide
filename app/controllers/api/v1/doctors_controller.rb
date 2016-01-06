class Api::V1::DoctorsController < Api::ApiController

  def by_area_category
    area_id = params[:area_id]
    category_id = params[:category_id]

    divs = Division.joins(:div_hosp_doc_ships).where("divisions.category_id = #{category_id}").select('doctor_id').uniq{|x| x.doctor_id}
    doc_ids = divs.map{|item| item["doctor_id"].to_i}.join(",")
    doctors = Doctor.where("id in (#{doc_ids}) and area_id = #{area_id}").select('id,name,address')

    render :json => doctors
  end
end
