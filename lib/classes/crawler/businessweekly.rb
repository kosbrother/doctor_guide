# encoding: utf-8
class Crawler::Businessweekly
  include Crawler
  
  def crawl_bw_doctors_url
    nodes = @page_html.css('.searchresults a')
    nodes.each do |node|
      link = get_url(node[:href])
      lis =  node.css("li")
      addr = ""
      lis.each do |li|
        strong = li.css("strong")
        if strong.text.match(/地.*址/)
          li.css("strong,a").remove
          addr = li.text.strip
        end
      end

      em = node.css('em')
      name = em.text.split(' ')[0]

      d = Doctor.find_or_initialize_by(name: name,address: addr)
      d.bUrl = link
      if d.new_record?
        d.save
        BusinessweeklyDoctorDetailWorker.perform_async(d.id) unless Rails.env.test?
      end
      d.save
    end
  end

  # def crawl_hosp_detail hosp
  #   lis = @page_html.css(".detailinfo li")
    
  #   phone = ""
  #   lis.each do |li|
  #     strong = li.css("strong")
  #     if strong.text.match(/電.*話/)
  #       li.css("strong").remove
  #       phone = li.text.strip.gsub(" ","")
  #     end
  #   end

  #   addr = ""
  #   lis.each do |li|
  #     strong = li.css("strong")
  #     if strong.text.match(/地.*址/)
  #       li.css("strong,a").remove
  #       addr = li.text.strip
  #     end
  #   end

  #   services = ""
  #   lis.each do |li|
  #     strong = li.css("strong")
  #     if strong.text.match(/服務項目/)
  #       li.css("strong").remove
  #       services = li.text.strip.gsub(" ","").split("、").map {|s| s.strip }
  #     end
  #   end

  #   hosp.phone = phone
  #   hosp.address = addr
  #   hosp.ss = (services.blank?)? [] : services
  #   hosp.save
  # end

  def crawl_doctor_detail doctor
    lis = @page_html.css(".detailinfo li")
    div = lis[0].css("a").text

    hosp = ""
    hosp_link = ""
    lis.each do |li|
      strong = li.css("strong")
      if strong.text == "醫院名稱："
        hosp = li.css("a").text
        hosp_link = get_url(li.css("a")[0][:href])
      end
    end

    phone = ""
    lis.each do |li|
      strong = li.css("strong")
      if strong.text.match(/電.*話/)
        li.css("strong").remove
        phone = li.text.strip.gsub(" ","")
      end
    end

    addr = ""
    lis.each do |li|
      strong = li.css("strong")
      if strong.text == "醫院地址："
        li.css("a,strong").remove
        addr = li.text.strip
      end
    end

    name = @page_html.css(".doct_name h1").text.gsub("醫師","").strip
    spes = @page_html.css("li#ContentPlaceHolder1_IDoctorHead1_professional li")
    exps = @page_html.css("li#ContentPlaceHolder1_IDoctorHead1_experience li")

    hospital = Hospital.find_or_initialize_by(address: addr)
    if hospital.new_record?
      hospital.name = hosp
      hospital.save
      # @c = Crawler::Businessweekly.new
      # @c.fetch hosp_link
      # @c.crawl_hosp_detail hospital
    end
    
    division = Division.find_or_initialize_by(name: div)
    division.save
    
    doctor.address = addr
    doctor.phone = phone
    doctor.name = name
    doctor.spe = spes.collect{|x| x.text}.join("、")
    doctor.exp = exps.collect{|x| x.text}.join("、")
    doctor.save

    ship = DivHospDocShip.new
    ship.hospital = hospital
    ship.division = division

    doctor.div_hosp_doc_ships << ship

  end
end