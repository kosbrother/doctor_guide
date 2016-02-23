require 'elasticsearch/persistence'
class ImportDataController < ApplicationController
  def import_doctors
    repository = Elasticsearch::Persistence::Repository.new
    repository.index = "doctors_index"
    repository.type = 'doctor'
    repository.create_index! force: true
    doctors = DivHospDocShip.uniq{|x| x.doctor_id}.joins(:doctor, :hospital).select('doctors.id,doctors.name,hospitals.name as hospital_name,hospitals.id as hospital_id,doctors.latitude,doctors.longitude,doctors.comment_num,doctors.recommend_num,doctors.avg')
    doctors.each do |v|
      repository.save(v.as_json)
    end
    render :json => "success"
  end
  
  def import_hospitals
    repository = Elasticsearch::Persistence::Repository.new
    repository.index = "hospitals_index"
    repository.type = 'hospital'
    repository.create_index! force: true
    #repository.delete_index?
    hospitals = Hospital.all
    hospitals.each do |v|
      repository.save(v.as_json)
    end
    render :json => "success"
  end  
end
