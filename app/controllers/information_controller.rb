class InformationController < ApplicationController
  def hospital
    hospital_id = params['hospital']
    @hospital = Hospital.find(hospital_id)
    @divisions = @hospital.divisions.uniq{|x| x.id}
    @goodDivisions =  @hospital.comments.select("name, category_id, sum(div_friendly) as total").joins('LEFT OUTER JOIN `divisions` ON `divisions`.`id` = `comments`.`division_id`').group('division_id').order('total desc').limit(10)
    @popDivisions =  @hospital.comments.select("name, category_id, count(div_comment) as total").joins('LEFT OUTER JOIN `divisions` ON `divisions`.`id` = `comments`.`division_id`').group('division_id').order('total desc').limit(10)
    @goodDoctors =  @hospital.comments.select("name, doctor_id,  sum(dr_friendly) as total").joins('LEFT OUTER JOIN `doctors` ON `doctors`.`id` = `comments`.`doctor_id`').group('doctor_id').order('total desc').limit(10)
    @popDoctors =  @hospital.comments.select("name, doctor_id, count(dr_comment) as total").joins('LEFT OUTER JOIN `doctors` ON `doctors`.`id` = `comments`.`doctor_id`').group('doctor_id').order('total desc').limit(10)
    @doctorComments = @hospital.comments.where.not(dr_comment: nil).where.not(dr_comment: "").paginate(:page => params[:page]).per_page(3)
    @divisionComments = @hospital.comments.where.not(div_comment: nil).where.not(div_comment: "").paginate(:page => params[:page]).per_page(3)
  end

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

  def not_found
    render :file => 'public/404.html', :status => :not_found
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
    else
      not_found
    end


  end
end
