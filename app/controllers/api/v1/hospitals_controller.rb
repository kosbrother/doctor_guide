class Api::V1::HospitalsController < Api::ApiController

  def by_area_category
    area_id = params[:area_id]
    category_id = params[:category_id]

    divs = Division.joins(:div_hosp_doc_ships).where("divisions.category_id = #{category_id}").select('hospital_id').uniq{|x| x.hospital_id}
    hosp_ids = divs.map{|item| item["hospital_id"].to_i}.join(",")
    hopitals = Hospital.where("id in (#{hosp_ids}) and area_id = #{area_id}").select('id,name,address,grade')

    render :json => hopitals
  end
end
