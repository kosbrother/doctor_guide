class Api::V1::DivisionsController < Api::ApiController

  def by_hospital_category
    hospital_id = params[:hospital_id]
    category_id = params[:category_id]

    hospital = Hospital.find(hospital_id)
    divisions = hospital.divisions.where("category_id = #{category_id} and div_hosp_doc_ships.doctor_id is not null").uniq{|x| x.id}

    render :json => divisions
  end
end
