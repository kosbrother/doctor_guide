class DivHospDocShip < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :hospital
  belongs_to :division
end
