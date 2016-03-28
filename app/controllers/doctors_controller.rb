class DoctorsController < ApplicationController
  def index
  end

  def show

    relation = DivHospDocShip.find_by(doctor_id: params['id'], hospital_id: params['hospital_id'], division_id: params['division_id'])
    if relation
      @doctor = relation.doctor
      @hospital = relation.hospital
      @division = relation.division
      @comments = Comment.where(doctor_id: params['id']).paginate(:page => params[:page]).per_page(3)
      @drFriendly = @comments.average(:dr_friendly).to_f
      @drSpeciality = @comments.average(:dr_speciality).to_f
      @avgDocRate = ((@drFriendly + @drSpeciality) / 2).round(1)
      @area = @doctor.area
      @goodDoctors = Doctor.select('doctors.*').joins('INNER JOIN div_hosp_doc_ships ON doctors.id = div_hosp_doc_ships.`doctor_id`').where("doctors.area_id = #{@area.id} AND div_hosp_doc_ships.division_id = #{@division.id}").order('doctors.recommend_num desc').limit(10)
      @popDoctors = Doctor.select('doctors.*').joins('INNER JOIN div_hosp_doc_ships ON doctors.id = div_hosp_doc_ships.`doctor_id`').where("doctors.area_id = #{@area.id} AND div_hosp_doc_ships.division_id = #{@division.id}").order('doctors.comment_num desc').limit(10)
    else
      not_found
    end
  end

  def recommend
    @doctors = Doctor.order('recommend_num desc').paginate(page: params['page'], total_entries: 100).per_page(20)
  end

  def popular
    @doctors = Doctor.order('comment_num desc').paginate(page: params['page'], total_entries: 100).per_page(20)
  end

  def area_recommend
  end

  def hospital_recommend

  end

  def area_categories_recommend

  end
end
