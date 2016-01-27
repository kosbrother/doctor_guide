class Comment < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :hospital
  belongs_to :division
  belongs_to :commentor, :class_name => 'User', :foreign_key => 'user_id'

  scope :select_comment, -> { joins(:doctor,:hospital,:division,:commentor).select('
        comments.id,dr_friendly,dr_speciality,div_equipment,div_environment,div_speciality,div_friendly,doctor_id,hospital_id,division_id,div_comment,dr_comment,is_recommend,user_id,
        users.name as user_name, hospitals.name as hospital_name, divisions.name as division_name, doctors.name as doctor_name
        ') }

  def comment_date
    updated_at.localtime.strftime("%Y/%m/%d")
  end
end
