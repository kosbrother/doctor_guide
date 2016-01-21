class Division < ActiveRecord::Base
  belongs_to :category
  has_many :div_hosp_doc_ships
  has_many :doctors, :through => :div_hosp_doc_ships
  has_many :div_hosp_doc_ships
  has_many :hospitals, :through => :div_hosp_doc_ships
  has_many :comments

  def avg_score(hospital_id)
    scores = comments.where(hospital_id: hospital_id).select("( AVG(div_equipment) + AVG(div_environment) + AVG(div_speciality) + AVG(div_friendly) )/4 as avg_score")
    scores[0].avg_score
  end
end
