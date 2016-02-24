class Api::V1::SearchController < Api::ApiController
  def search_doctors
    if params[:q].nil?
      doctors = []
    else
      repository = Elasticsearch::Persistence::Repository.new
      repository.index = "doctors_index"
      repository.type = 'doctor'
      doctors = repository.search({query: { match: { name: params[:q] } }, size: 30})   
    end
    render :json => doctors.to_json(methods: [:search_hospital, :search_hospital_id], only: [:id, :name, :hospital_name, :hospital_id, :latitude, :longitude, :comment_num, :recommend_num, :avg])
  end
  def search_hospitals
    if params[:q].nil?
      hospitals = []
    else
      repository = Elasticsearch::Persistence::Repository.new
      repository.index = "hospitals_index"
      repository.type = 'hospital'
      hospitals = repository.search({query: { match: { name: params[:q] } }, size: 30})
    end
    render :json => hospitals.to_json(:only => [:id, :name, :address, :grade, :latitude, :longitude, :comment_num, :recommend_num, :avg])
  end  
end
