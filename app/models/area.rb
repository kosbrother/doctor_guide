class Area < ActiveRecord::Base
  has_many :hospitals
  has_many :doctors
end
