class Doctor < ActiveRecord::Base
  has_many :div_hosp_doc_ships
  has_many :hospitals, :through => :div_hosp_doc_ships
  has_many :divisions, :through => :div_hosp_doc_ships
  belongs_to :area

  geocoded_by :address
  after_validation :geocode

  acts_as_mappable :default_units => :miles,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude
end
