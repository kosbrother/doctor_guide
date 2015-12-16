require 'rails_helper'
require 'classes/crawler'
require 'classes/crawler/commonhealth'

describe "commonhealth_doctor_crawler" do

  before(:all){
    @doc = Doctor.create(coUrl: "http://www.commonhealth.com.tw/medical/doctorInfo.action?nid=25")
    @c = Crawler::Commonhealth.new
    @c.fetch @doc.coUrl
    @c.crawl_doctor_detail @doc
  }

  it "crawl doctor' name" do
    expect(@doc.name).to eq("劉燦宏")
  end

  it "crawl division" do
    expect(@doc.div).to eq("復健科")
  end

  it "crawl experience" do
    expect(@doc.exp).to eq("台北醫學大學副教授、雙和醫院復健醫學部部主任、萬芳醫院復健醫學部主任、萬芳醫院肥胖防治中心主任、署立澎湖醫院復健科主任、台大署立桃園醫院復健科住院醫師、美國哥倫比亞大學紐約肥胖研究中心")
  end

  it "crawl specialty" do
    expect(@doc.spe).to eq("腦中風頭部外傷、脊髓損傷、運動傷害、腦性麻痺、感覺統合等復健、肥胖症之診斷、預防、治療及研究兒童肥胖、產後肥胖、減肥藥物諮詢、運動減肥及減重班課程")
  end

  it "crawl doctor's hospital" do
    expect(@doc.hospitals[0].name).to eq("衛生福利部雙和醫院")
    # expect(@doc.hospitals.count).to be > 0
  end

  it "crawl doctor's phone" do
    expect(@doc.phone).to eq("(02)22490088")
  end

  it "crawl doctor's address" do
    expect(@doc.address).to eq("新北市中和區中正路291號")
  end

  it "set doctor and hospital relation" do
    expect(@doc.hospitals.size).to be > 0
    expect(@doc.hospitals[0].doctor_ids.include? @doc.id).to be true
  end

end

describe 'crawl doctors' do
  it "crawel doctors url" do
    index_url = "http://www.commonhealth.com.tw/medical/findDoctor.action?&page=2"
    c = Crawler::Commonhealth.new
    c.fetch index_url
    c.crawl_co_doctors_url

    expect(Doctor.count).to be > 1

    doctor = Doctor.all[1]
    expect(doctor.coUrl).not_to be nil
  end
end
