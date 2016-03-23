class InformationController < ApplicationController

  def division
    @hospital = Hospital.find(params['hospital'])
    @division = @hospital.divisions.find(params['division'])

    @otherDivisions = @hospital.divisions.where("div_hosp_doc_ships.doctor_id is not null and divisions.id != #{params['division']}").uniq{|x| x.id}
    if @otherDivisions.size == 0
      @otherDivisions = @hospital.divisions.where.not(id: params['division']).uniq{|x| x.id}
    end

    @comments = Comment.where(hospital_id: params['hospital'], division_id: params['division'])
    @recommendNum = @comments.where(is_recommend: true).count
    @commentNum = @comments.where.not(div_comment: (nil || "")).count
    @divEquipment =  @comments.average(:div_equipment).to_f
    @divEnvironment = @comments.average(:div_environment).to_f
    @divSpeciality = @comments.average(:div_speciality).to_f
    @divFriendly = @comments.average(:div_friendly).to_f
    @avgRate = ( @divEquipment + @divEnvironment + @divSpeciality + @divFriendly) / 4
    @drFriendly = @comments.average(:dr_friendly).to_f
    @drSpeciality = @comments.average(:dr_speciality).to_f
    @avgDocRate = (@drFriendly + @drSpeciality) / 2
    @doctors = @hospital.doctors.limit(8)
    # TODO need to figure out how to call divisions doctors
    @commentsPage =  @comments.where.not(div_comment: (nil || "")).paginate(:page => params[:page]).per_page(3)
  end

  def doctor
    relation = DivHospDocShip.find_by(doctor_id: params['doctor'], hospital_id: params['hospital'], division_id: params['division'])
    if relation
      @doctor = relation.doctor
      @hospital = relation.hospital
      @division = relation.division
      @comments = Comment.where(doctor_id: params['doctor']).paginate(:page => params[:page]).per_page(3)
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

  def doctorId
    @doctor = Doctor.find(params['doctor'])
    @hospital = @doctor.hospitals[0]
    params['hospital'] = @hospital.id
    @division = @doctor.divisions.where("div_hosp_doc_ships.doctor_id = #{@doctor.id} AND div_hosp_doc_ships.hospital_id = #{params['hospital']}" )[0]
    params['division'] = @hospital.id

    redirect_to doctor_path(@hospital.id, @division.id,@doctor.id )
  end
end
