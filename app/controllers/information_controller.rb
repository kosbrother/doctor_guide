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
    #  TODO validate if hospital has this division
    @otherDivisions = @hospital.divisions.where.not(id: params['division']).limit(10)
  end

  def doctor

  end
end
