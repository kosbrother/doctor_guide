class Comment < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :hospital
  belongs_to :division
  belongs_to :commentor, :class_name => 'User', :foreign_key => 'user_id'

  def comment_date
    updated_at.localtime.strftime("%Y/%m/%d")
  end
end
