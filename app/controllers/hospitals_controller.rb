class HospitalsController < ApplicationController
  def show
    hospital_id = params['id']
    @hospital = Hospital.friendly.find(hospital_id)
    set_meta_tags title: @hospital.name
    @divisions = @hospital.divisions.uniq{|x| x.id}
    @goodDivisions =  @hospital.comments.select("divisions.id, name, category_id, sum(div_friendly) as total, comments.updated_at").joins('LEFT OUTER JOIN `divisions` ON `divisions`.`id` = `comments`.`division_id`').group('division_id').order('total desc').limit(10)
    @popDivisions =  @hospital.comments.select("divisions.id, name, category_id, count(div_comment) as total, comments.updated_at").joins('LEFT OUTER JOIN `divisions` ON `divisions`.`id` = `comments`.`division_id`').group('division_id').order('total desc').limit(10)
    @goodDoctors =  @hospital.comments.select("comments.hospital_id, comments.division_id, name, doctor_id,  sum(dr_friendly) as total, comments.updated_at").joins('LEFT OUTER JOIN `doctors` ON `doctors`.`id` = `comments`.`doctor_id`').group('doctor_id').order('total desc').limit(10)
    @popDoctors =  @hospital.comments.select("comments.hospital_id, comments.division_id, name, doctor_id, count(dr_comment) as total, comments.updated_at").joins('LEFT OUTER JOIN `doctors` ON `doctors`.`id` = `comments`.`doctor_id`').group('doctor_id').order('total desc').limit(10)
    @doctorComments = @hospital.comments.where.not(dr_comment: nil).where.not(dr_comment: "").paginate(:page => params[:page]).per_page(3)
    @divisionComments = @hospital.comments.where.not(div_comment: nil).where.not(div_comment: "").paginate(:page => params[:page]).per_page(3)
  end

  def recommend
    @hospitals = Hospital.order('recommend_num desc').paginate(page: params['page'], total_entries: 100).per_page(20)
  end

  def popular
    @hospitals = Hospital.order('comment_num desc').paginate(page: params['page'], total_entries: 100).per_page(20)
  end

  def area_recommend
    @hospitals = Hospital.where(area_id: params['id']).order('recommend_num desc').paginate(page: params['page'], total_entries: 100).per_page(20)
  end

  def area_popular
    @hospitals = Hospital.where(area_id: params['id']).order('comment_num desc').paginate(page: params['page'], total_entries: 100).per_page(20)
  end

end
