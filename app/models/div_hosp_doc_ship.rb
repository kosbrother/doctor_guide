require 'elasticsearch/model'

class DivHospDocShip < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :doctor
  belongs_to :hospital
  belongs_to :division
end
