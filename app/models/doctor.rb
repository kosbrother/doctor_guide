require 'elasticsearch/model'

class Doctor < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  def slug_candidates
    [
      [:id, :name]
    ]
  end

  has_many :div_hosp_doc_ships
  has_many :hospitals, :through => :div_hosp_doc_ships
  has_many :divisions, :through => :div_hosp_doc_ships
  has_many :comments
  belongs_to :area
  attr_accessor :search_hospital_id
  attr_accessor :search_hospital

  geocoded_by :address
  after_validation :geocode

  acts_as_mappable :default_units => :miles,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  def avg_score
    scores = comments.select("( AVG(dr_friendly) + AVG(dr_speciality) )/2 as avg_score")
    (scores[0].avg_score.nil?) ? 0 : scores[0].avg_score
  end

  def avg_friendly
    scores = comments.select("AVG(dr_friendly) as avg_score")
    (scores[0].avg_score.nil?) ? 0 : scores[0].avg_score
  end
  def avg_speciality
    scores = comments.select("AVG(dr_speciality) as avg_score")
    (scores[0].avg_score.nil?) ? 0 : scores[0].avg_score
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s
  end

end

#Doctor.import force: true
