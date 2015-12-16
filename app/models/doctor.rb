class Doctor < ActiveRecord::Base
  has_many :div_hosp_doc_ships
  has_many :hospitals, :through => :div_hosp_doc_ships
end
