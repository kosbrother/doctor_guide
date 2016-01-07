class Api::V1::DivisionsController < Api::ApiController

  def by_hospital_category
    hospital_id = params[:hospital_id]
    category_id = params[:category_id]

    hospital = Hospital.find(hospital_id)
    divisions = hospital.divisions.where("category_id = #{category_id} and div_hosp_doc_ships.doctor_id is not null").uniq{|x| x.id}.select("divisions.id,divisions.name")
    if divisions.size == 0
      divisions = hospital.divisions.where("category_id = #{category_id}").uniq{|x| x.id}.select("divisions.id,divisions.name")
    end
    render :json => divisions
  end

  def by_hospital
    hospital_id = params[:hospital_id]
    divisions = Division.joins(:div_hosp_doc_ships).where("div_hosp_doc_ships.hospital_id = #{hospital_id} and div_hosp_doc_ships.doctor_id is not null").uniq{|x| x.id}.select("divisions.id,divisions.name")
    render :json => divisions
  end
end
