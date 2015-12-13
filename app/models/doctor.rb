class Doctor < ActiveRecord::Base
  validates :name, presence: true
  has_many :hospital_doctorships
  has_many :hospitals, :through => :hospital_doctorships
end
