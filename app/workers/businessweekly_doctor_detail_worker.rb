# encoding: utf-8
class BusinessweeklyDoctorDetailWorker
  include Sidekiq::Worker
  
  def perform(doc_id)
    @doc = Doctor.find(doc_id)
    @c = Crawler::Businessweekly.new
    @c.fetch @doc.bUrl
    @c.crawl_doctor_detail @doc
  end
end