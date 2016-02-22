class Api::V1::SearchController < Api::ApiController
  def search_doctors
    if params[:q].nil?
      doctors = []
    else
      repository = Elasticsearch::Persistence::Repository.new
      repository.index = "doctors_index"
      repository.type = 'doctor'
      doctors = repository.search(query: { match: { name: params[:q] } })   
    end
    render :json => doctors.to_json(:methods => [:hospital_name, :hospital_id]) 
  end
  def search_hospitals
    if params[:q].nil?
      hospitals = []
    else
      repository = Elasticsearch::Persistence::Repository.new
      repository.index = "hospitals_index"
      repository.type = 'hospital'
      hospitals = repository.search(query: { match: { name: params[:q] } })
    end
    render :json => hospitals
  end  
end
