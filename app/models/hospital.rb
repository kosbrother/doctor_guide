class Hospital < ActiveRecord::Base
  has_many :hospital_doctorships
  has_many :doctors, :through => :hospital_doctorships
  serialize :divs
  serialize :ss
end
