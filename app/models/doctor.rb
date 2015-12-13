class Doctor < ActiveRecord::Base
  has_many :hospital_doctorships
  has_many :hospitals, :through => :hospital_doctorships
end
