class Hospital < ActiveRecord::Base
  has_many :div_hosp_doc_ships
  has_many :doctors, :through => :div_hosp_doc_ships
  has_many :divisions, :through => :div_hosp_doc_ships
  has_many :comments
  belongs_to :area
  
  serialize :divs
  serialize :ss
  serialize :cHours, Hash

  geocoded_by :address
  after_validation :geocode

  acts_as_mappable :default_units => :miles,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  def avg_score
    scores = comments.select("( AVG(div_equipment) + AVG(div_environment) + AVG(div_speciality) + AVG(div_friendly) )/4 as avg_score")
    scores[0].avg_score
  end
end
