require 'rails_helper'
require 'classes/crawler'
require 'classes/crawler/nhi'

describe "nhi_crawler" do

  before(:all){
    @hosp = Hospital.create(nhiUrl: "http://www.nhi.gov.tw/Query/Query3_Detail.aspx?HospID=1101150011")
    @c = Crawler::Nhi.new
    @c.fetch @hosp.nhiUrl
    @c.crawl_detail @hosp
  }

  it "code" do
    expect(@hosp.code).to eq("1101150011")
  end

  it "name" do
    expect(@hosp.name).to eq("新光醫療財團法人新光吳火獅紀念醫院")
  end

  it "phone" do
    expect(@hosp.phone).to eq("02-28332211")
  end

  it "address" do
    expect(@hosp.address).to eq("台北市士林區文昌路９５號及士商路５１號１至７樓５３、５５號")
  end

  it "grade" do
    expect(@hosp.grade).to eq("醫學中心")
  end

  it "services" do
    s = "復健－物理治療業務、復健－職能治療業務、住院安寧療護、復健－語言治療業務、門診診療、住院診療、血液透析、兒童預防保健、成人預防保健、婦女子宮頸抹片檢查、孕婦產檢、分娩、兒童牙齒預防保健、精神科日間住院治療、結核病、口腔黏膜檢查、定量免疫法糞便潛血檢查"
    services = s.split("、")
    expect(@hosp.ss).to match_array(services)
  end

  it "divisions" do
    s = "不分科、家醫科、內科、外科、兒科、婦產科、骨科、神經外科、泌尿科、耳鼻喉科、眼科、皮膚科、神經科、精神科、復健科、整形外科、職業醫學科、急診醫學科、牙科、齒顎矯正科、口腔顎面外科、麻醉科、放射線科、病理科、核子醫學科、放射腫瘤科"
    divisions = s.split("、")
    expect(@hosp.divs).to match_array(divisions)
  end

end
