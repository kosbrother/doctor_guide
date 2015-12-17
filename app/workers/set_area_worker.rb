# encoding: utf-8
class SetAreaWorker
  include Sidekiq::Worker
  
  def perform(hosp_id)
    setter = HospitalAreaSet.new
    hospital = Hospital.find(hosp_id)
    setter.set_hospital(hospital)
  end
end