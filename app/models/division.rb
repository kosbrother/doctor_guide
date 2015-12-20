class Division < ActiveRecord::Base
  belongs_to :category
  has_many :div_hosp_doc_ships
  has_many :doctors, :through => :div_hosp_doc_ships
  has_many :div_hosp_doc_ships
  has_many :hospitals, :through => :div_hosp_doc_ships
end
