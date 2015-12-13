class Hospital < ActiveRecord::Base
  validates :name, presence: true
end
