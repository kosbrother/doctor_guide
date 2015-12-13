# encoding: utf-8
class CommonhealthDoctorDetailWorker
  include Sidekiq::Worker
  
  def perform(doc_id)
    @doc = Doctor.find(doc_id)
    @c = Crawler::Commonhealth.new
    @c.fetch @doc.coUrl
    @c.crawl_doctor_detail @doc
  end
end