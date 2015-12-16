class Hospital < ActiveRecord::Base
  has_many :div_hosp_doc_ships
  has_many :doctors, :through => :div_hosp_doc_ships
  serialize :divs
  serialize :ss
  serialize :cHours, Hash
end
