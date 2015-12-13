class Doctor < ActiveRecord::Base
  validates :name, presence: true
end
