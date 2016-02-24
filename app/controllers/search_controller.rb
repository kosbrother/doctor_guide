require 'elasticsearch/persistence'
class SearchController < ApplicationController
  def search_doctors
    if params[:q].nil?
      @doctors = []
    else
      repository = Elasticsearch::Persistence::Repository.new
      repository.index = "doctors_index"
      repository.type = 'doctor'
      @doctors = repository.search(query: { match: { name: params[:q] } })
    end
  end
  def search_hospitals
    if params[:q].nil?
      @hospitals = []
    else
      repository = Elasticsearch::Persistence::Repository.new
      repository.index = "hospitals_index"
      repository.type = 'hospital'
      @hospitals = repository.search(query: { match: { name: params[:q] } })
    end
  end  
end
