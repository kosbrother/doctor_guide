# encoding: utf-8
class NhiWorker
  include Sidekiq::Worker
  
  def perform(hosp_id)
    hosp = Hospital.find(hosp_id)
    @c = Crawler::Nhi.new
    @c.fetch hosp.nhiUrl
    @c.crawl_detail hosp
  end
end