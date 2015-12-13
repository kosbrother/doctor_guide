# encoding: utf-8
class Crawler::Commonhealth
  include Crawler

  def crawl_co_urls
    nodes = @page_html.css('.commonDrList a')
    nodes.each do |node|
      next if node[:href].include?("javascript")
      link = get_url(node[:href])
      name = node.css('img')[0][:alt]

      h = Hospital.find_or_initialize_by(name: name)
      h.coUrl = link
      h.save

      CommonhealthHospDetailWorker.perform_async(h.id)
    end
  end

  def crawl_detail hosp
    lis = @page_html.css(".commonDrContentMain li")
    grade = ""
    lis.each do |li|
      span = li.css("span")
      if span.text == "評級 ："
        li.css("span").remove
        grade = li.text
      end
    end

    time = {}

    lis = @page_html.css("li#businessTimeLi ul > li")
    lis.each do |li|
      span_text = li.css("span").text
      if span_text == "平日看診"
        time_text = []
        li.css("li").each do |li|
          time_text.append(li.text)
        end
        time["weekday"] = time_text
      end

      if span_text == "夜間看診"
        time_text = []
        li.css("li").each do |li|
          time_text.append(li.text)
        end
        time["night"] = time_text
      end

      if span_text == "假日看診"
        time_text = []
        li.css("li").each do |li|
          time_text.append(li.text)
        end
        time["holiday"] = time_text
      end

      if li.attr('class') == "textLeft"
        time["special"] = li.text
      end
    end
    
    hosp.cHours = time
    hosp.grade = grade
    hosp.save
  end

  def crawl_co_doctors_url
    nodes = @page_html.css('.commonDrList a')
    nodes.each do |node|
      next if node[:href].include?("javascript")
      link = node[:href]
      name = node.css('img')[0][:alt]

      d = Doctor.find_or_initialize_by(coUrl: link)
      d.name = name
      d.save

      CommonhealthDoctorDetailWorker.perform_async(d.id)
    end
  end

  def crawl_doctor_detail doctor
    name = @page_html.css(".commonDrContentMain h2.commonGreen").text

    lis = @page_html.css(".commonDrContentMain li")
    div = ""
    lis.each do |li|
      span = li.css("span")
      if span.text == "科別 ："
        li.css("span").remove
        div = li.text.strip
      end
    end

    exp = ""
    lis.each do |li|
      span = li.css("span")
      if span.text == "經歷 ："
        li.css("span").remove
        exp = li.text.strip
      end
    end

    specialty = ""
    lis.each do |li|
      span = li.css("span")
      if span.text == "專長 ："
        li.css("span").remove
        specialty = li.text.strip
      end
    end

    hosp_a = @page_html.css(".findDrInner li a")
    if hosp_a.present?
      hosp = hosp_a[0].css("strong").text.gsub("醫院：","")
      address = hosp_a[0].css("span")[0].text.gsub("地址：","")
      phone = hosp_a[0].css("span")[1].text.gsub("電話：","")

      hospital = Hospital.find_or_initialize_by(name: hosp)
      if hospital.new_record?
        hospital.address = address
        hospital.phone = phone
        hospital.save
      end
    end

    doctor.hospitals << hospital

    doctor.name = name
    doctor.div = div
    doctor.exp = exp
    doctor.spe = specialty
    doctor.hosp = hosp
    doctor.address = address
    doctor.phone = phone
    doctor.save

  end

end