# encoding: utf-8
class HospitalAreaSet
  def convert address
    /^(.*?)(縣|市)/ =~ address
    return "臺北市" if ["臺北","台北"].include? $1
    return "新北市" if ["新北"].include? $1
    return "桃園市" if ["桃園"].include? $1
    return "臺中市" if ["臺中","台中"].include? $1
    return "臺南市" if ["臺南","台南"].include? $1
    return "高雄市" if ["高雄"].include? $1

    return "基隆市" if ($1 + $2) == "基隆市"
    return "新竹市" if ($1 + $2) == "新竹市"
    return "嘉義市" if ($1 + $2) == "嘉義市"

    return "新竹縣" if ["新竹"].include? $1
    return "苗栗縣" if ["苗栗"].include? $1
    return "彰化縣" if ["彰化"].include? $1
    return "南投縣" if ["南投"].include? $1
    return "雲林縣" if ["雲林"].include? $1
    return "嘉義縣" if ["嘉義"].include? $1
    return "屏東縣" if ["屏東"].include? $1
    return "宜蘭縣" if ["宜蘭"].include? $1

    return "花蓮縣" if ["花蓮"].include? $1
    return "臺東縣" if ["臺東","台東"].include? $1
    return "澎湖縣" if ["澎湖"].include? $1
  end

  def set_hospital hospital
    a = Area.find_by(name: convert(hospital.address))
    hospital.area = a
    hospital.save
  end
end