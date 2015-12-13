# encoding: utf-8
class BusinessweeklyDocWorker
  include Sidekiq::Worker
  
  def perform(page)
    index_url = "http://health.businessweekly.com.tw/GSearchDoc.aspx?pro=0000&t=1&s=9&p="
    url = index_url + page.to_s
    c = Crawler::Businessweekly.new
    c.fetch url
    c.crawl_bw_doctors_url
  end
end