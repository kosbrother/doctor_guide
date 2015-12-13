class Hospital < ActiveRecord::Base
  validates :name, presence: true
  has_many :hospital_doctorships
  has_many :doctors, :through => :hospital_doctorships
end
