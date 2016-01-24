class Area < ActiveRecord::Base
  has_many :hospitals
  has_many :doctors

  geocoded_by :name
  after_validation :geocode
end
