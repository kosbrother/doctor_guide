# encoding: utf-8
require 'elasticsearch/persistence'
namespace :elasticsearch do
  task :import_doctors => :environment do
    repository = Elasticsearch::Persistence::Repository.new
    repository.index = "doctors_index"
    repository.type = 'doctor'
    repository.create_index! force: true
    doctors = DivHospDocShip.uniq{|x| x.doctor_id}.joins(:doctor, :hospital).select('doctors.id,doctors.name,hospitals.name as search_hospital,hospitals.id as search_hospital_id,doctors.latitude,doctors.longitude,doctors.comment_num,doctors.recommend_num,doctors.avg')
    doctors.each do |v|
      repository.save(v.as_json)
    end
    puts "success"
  end
  task :import_hospitals => :environment do
    repository = Elasticsearch::Persistence::Repository.new
    repository.index = "hospitals_index"
    repository.type = 'hospital'
    repository.create_index! force: true
    #repository.delete_index?
    hospitals = Hospital.all
    hospitals.each do |v|
      repository.save(v.as_json)
    end
    puts "success"
  end
end