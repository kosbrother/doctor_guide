# encoding: utf-8
class CommonhealthHospWorker
  include Sidekiq::Worker
  
  def perform(page)
    index_url = "http://www.commonhealth.com.tw/medical/findHospital.action?&policlinic=0&page="
    url = index_url + page.to_s
    c = Crawler::Commonhealth.new
    c.fetch url
    c.crawl_co_urls
  end
end