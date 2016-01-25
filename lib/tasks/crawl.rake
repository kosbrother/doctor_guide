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
    (1..2056).each do |page|
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

  task :set_area => :environment do
    Hospital.where("area_id is null").find_in_batches.each do |hospitals|
      hospitals.each do |hospital|
        SetAreaWorker.perform_async(hospital.id)
      end
    end
  end

  task :crawl_businessweekly_comment => :environment do
    Doctor.where.not(bUrl: nil).each do |doctor|
      @c = Crawler::Businessweekly.new
      @c.fetch doctor.bUrl
      @c.crawl_comment doctor
    end
  end

  task :set_score => :environment do
    Comment.all.each do |c|
      params = {}
      params["dr_friendly"] = 3 + Random.rand(3)
      params["dr_speciality"] = 3 + Random.rand(3)
      params["div_equipment"]  = 3 + Random.rand(3)
      params["div_environment"]  = 3 + Random.rand(3)
      params["div_speciality"]  = 3 + Random.rand(3)
      params["div_friendly"]  = 3 + Random.rand(3)
      params["is_recommend"] = true
      c.update_columns(params)
    end
  end

  task :set_model_score => :environment do
    Hospital.find_in_batches.each do |hospitals|
      hospitals.each do |hospital|
        params = {}
        params["comment_num"] = hospital.comments.size
        params["recommend_num"] = hospital.comments.where(is_recommend: true).size
        params["avg"] = hospital.avg_score
        hospital.update_columns(params)
      end
    end

    Doctor.find_in_batches.each do |doctors|
      doctors.each do |doctor|
        params = {}
        params["comment_num"] = doctor.comments.size
        params["recommend_num"] = doctor.comments.where(is_recommend: true).size
        params["avg"] = doctor.avg_score
        doctor.update_columns(params)
      end
    end
  end

  # 康健的醫師有的超過兩個 division , split it
  # Division.where('id >= 34').each do |div|
  #   if div.name.split('、').size > 1
  #      divs = []
  #      div.name.split('、').each do |d_name|
  #        new_d = Division.find_or_initialize_by(name: d_name)
  #        new_d.save
  #        divs << new_d
  #      end
  #      div.doctors.each do |doc|
  #        doc.divisions << divs
  #      end
  #      div.delete
  #   end
  # end
end