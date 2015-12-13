# encoding: utf-8
class CommonhealthHospDetailWorker
  include Sidekiq::Worker
  
  def perform(id)
    @hosp = Hospital.find(id)
    @c = Crawler::Commonhealth.new
    @c.fetch @hosp.coUrl
    @c.crawl_detail @hosp
  end
end