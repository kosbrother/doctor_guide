# encoding: utf-8
class CommonhealthDocWorker
  include Sidekiq::Worker
  
  def perform(page)
    index_url = "http://www.commonhealth.com.tw/medical/findDoctor.action?&page="
    url = index_url + page.to_s
    c = Crawler::Commonhealth.new
    c.fetch url
    c.crawl_co_doctors_url
  end
end