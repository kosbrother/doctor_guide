# encoding: utf-8
class Crawler::Nhi
  include Crawler
  
  def crawle_hospital_urls
    trs = @page_html.css('#gvQuery3Data tr')
    trs.shift
    trs.each do |tr|
      tds = tr.css("td")
      h = Hospital.new
      if tds[3].text.strip.blank?
        h.on = true
      else
        h.on = false
      end
      a_node = tr.css('[id*="lblHospName"] a')
      h.nhiUrl = get_url(a_node[0][:href])
      h.save
      NhiWorker.perform_async(h.id)
    end
  end

  def crawl_detail hosp
    code = @page_html.css("#lblHospID").text
    name = @page_html.css("#lblHospName").text
    phone = @page_html.css("#lblTel").text
    address = @page_html.css("#lblAddress").text
    grade = @page_html.css("#lblSpecial").text
    services = @page_html.css("#lblService").text.split("、")
    divs = @page_html.css("#lblFunc").text.split("、")

    hosp.code = code
    hosp.name = name
    hosp.phone = phone
    hosp.address = address
    hosp.grade = grade
    hosp.ss = services

    divs.each do |div|
      division = Division.find_or_initialize_by(name: div.strip.gsub('‍',""))
      division.save
      hosp.divisions << division
    end

    hosp.save
  end
end