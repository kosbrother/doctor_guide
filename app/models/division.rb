class Division < ActiveRecord::Base
  belongs_to :category
  has_many :div_hosp_doc_ships
  has_many :doctors, :through => :div_hosp_doc_ships
  has_many :div_hosp_doc_ships
  has_many :hospitals, :through => :div_hosp_doc_ships
  has_many :comments

  def avg_score(hospital_id)
    scores = comments.where(hospital_id: hospital_id, division_id: id).select("( AVG(div_equipment) + AVG(div_environment) + AVG(div_speciality) + AVG(div_friendly) )/4 as avg_score")
    (scores[0].avg_score.nil?) ? 0 : scores[0].avg_score
  end

  def score_json(hospital_id)
    scores = comments.where(hospital_id: hospital_id, division_id: id).
    select("( AVG(div_equipment) + AVG(div_environment) + AVG(div_speciality) + AVG(div_friendly) )/4 as avg,
      count(*) as comment_num,
      AVG(div_equipment) as avg_equipment,
      AVG(div_environment) as avg_environment,
      AVG(div_speciality) as avg_speciality,
      AVG(div_friendly) as avg_friendly")
    score = scores[0].as_json(only: [:avg,:comment_num,:avg_equipment,:avg_environment,:avg_speciality,:avg_friendly])
    score["avg"] = 0 if score["avg"].nil?
    score["avg_equipment"] = 0 if score["avg_equipment"].nil? 
    score["avg_environment"] = 0 if score["avg_environment"].nil? 
    score["avg_speciality"] = 0 if score["avg_speciality"].nil? 
    score["avg_friendly"] = 0 if score["avg_friendly"].nil? 
    score["recommend_num"] = comments.where(hospital_id: hospital_id, division_id: id, is_recommend: true).size
    score["id"] = id
    score
  end
end
