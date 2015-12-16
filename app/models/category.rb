class Category < ActiveRecord::Base
  has_many :divisions
  has_many :hospitals, :through => :divisions
end
