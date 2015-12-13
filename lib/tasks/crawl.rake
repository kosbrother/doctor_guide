# encoding: utf-8
namespace :crawl do
  task :crawl_nhi_hospitals => :environment do
    
    # 26筆
    @c = Crawler::Nhi.new
    @c.post_fetch("http://www.nhi.gov.tw/Query/query3_list.aspx",{SpecialCode: 1, PageNum: 100})
    @c.crawle_hospital_urls

    # 85 筆
    @c.post_fetch("http://www.nhi.gov.tw/Query/query3_list.aspx",{SpecialCode: 2, PageNum: 100})
    @c.crawle_hospital_urls

    # 392 筆
    @c.post_fetch("http://www.nhi.gov.tw/Query/query3_list.aspx",{SpecialCode: 3, PageNum: 400})
    @c.crawle_hospital_urls

    # 21841 筆
    @c.post_fetch("http://www.nhi.gov.tw/Query/query3_list.aspx",{SpecialCode: 4, PageNum: 22000})
    @c.crawle_hospital_urls
  end

  task :crawl_commonhealth_hospitals => :environment do
    # 1..2056
    (1..200).each do |page|
      CommonhealthHospWorker.perform_async(page)
    end
  end

  task :crawl_commonhealth_doctors => :environment do
    # 1..131
    (1..131).each do |page|
      CommonhealthDocWorker.perform_async(page)
    end
  end

  task :crawl_businessweekly_doctors => :environment do
    # 1..358
    (1..358).each do |page|
      BusinessweeklyDocWorker.perform_async(page)
    end
  end
end