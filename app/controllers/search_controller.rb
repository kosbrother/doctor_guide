require 'elasticsearch/model'
class SearchController < ApplicationController

  def search
    if request.post?
      url = "/search?&q=#{params['search']}"
      encoded_url = URI.encode(url)
      redirect_to   URI.parse(encoded_url).to_s
    elsif request.get?
      search_doctors
      search_hospitals
    end
  end


  def search_doctors
    if params[:q].nil?
      @doctors = []
    else
      repository = Elasticsearch::Persistence::Repository.new
      repository.index = "doctors_index"
      repository.type = 'doctor'
      @doctors = repository.search({query: { match: { name: params[:q] } }, size: 20})
    end
  end
  def search_hospitals
    if params[:q].nil?
      @hospitals = []
    else
      repository = Elasticsearch::Persistence::Repository.new
      repository.index = "hospitals_index"
      repository.type = 'hospital'
      @hospitals = repository.search({query: { match: { name: params[:q] } }, size: 20})
    end
  end

end
