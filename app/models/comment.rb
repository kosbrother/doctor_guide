class Comment < ActiveRecord::Base
  after_save :update_score
  after_destroy :update_score

  default_scope { order('comments.updated_at desc') }

  belongs_to :doctor
  belongs_to :hospital
  belongs_to :division
  belongs_to :commentor, :class_name => 'User', :foreign_key => 'user_id'

  scope :select_doctor_comment, -> { joins(:doctor,:hospital,:division,:commentor).select('
        comments.id,dr_friendly,dr_speciality,div_equipment,div_environment,div_speciality,div_friendly,doctor_id,hospital_id,division_id,div_comment,dr_comment,is_recommend,user_id,
        users.name as user_name, hospitals.name as hospital_name, divisions.name as division_name, doctors.name as doctor_name,comments.updated_at
        ') }

  scope :select_division_comment, -> { joins("LEFT JOIN doctors ON doctor_id = doctors.id").joins(:hospital,:division,:commentor).select('
        comments.id,dr_friendly,dr_speciality,div_equipment,div_environment,div_speciality,div_friendly,doctor_id,hospital_id,division_id,div_comment,dr_comment,is_recommend,user_id,
        users.name as user_name, hospitals.name as hospital_name, divisions.name as division_name, doctors.name as doctor_name,comments.updated_at
        ') }

  def comment_date
    updated_at.localtime.strftime("%Y/%m/%d")
  end

  def update_score
    if doctor_id != nil
      params = {}
      params["comment_num"] = doctor.comments.size
      params["recommend_num"] = doctor.comments.where(is_recommend: true).size
      params["avg"] = doctor.avg_score
      doctor.update_columns(params)
    end
    if hospital_id != nil
      params = {}
      params["comment_num"] = hospital.comments.size
      params["recommend_num"] = hospital.comments.where(is_recommend: true).size
      params["avg"] = hospital.avg_score
      hospital.update_columns(params)
    end
  end
end
