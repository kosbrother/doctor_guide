class Hospital < ActiveRecord::Base
  has_many :div_hosp_doc_ships
  has_many :doctors, :through => :div_hosp_doc_ships
  has_many :divisions, :through => :div_hosp_doc_ships
  belongs_to :area
  
  serialize :divs
  serialize :ss
  serialize :cHours, Hash

  geocoded_by :address
  after_validation :geocode
end
