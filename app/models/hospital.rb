class Hospital < ActiveRecord::Base
  has_many :divisions
  has_many :doctors, :through => :divisions
  serialize :divs
  serialize :ss
  serialize :cHours, Hash
end
