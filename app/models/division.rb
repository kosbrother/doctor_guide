class Division < ActiveRecord::Base
  belongs_to :category
  belongs_to :hospital
  belongs_to :doctor
end
