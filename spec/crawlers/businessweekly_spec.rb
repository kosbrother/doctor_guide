require 'rails_helper'
require 'classes/crawler'
require 'classes/crawler/businessweekly'

describe "businessweekly_crawler" do

  before(:all){
    @doc = Doctor.create(bUrl: "http://health.businessweekly.com.tw/IDoctor.aspx?id=DOC0000002059")
    @c = Crawler::Businessweekly.new
    @c.fetch @doc.bUrl
    @c.crawl_doctor_detail @doc
  }

  it "crawel doctors url" do
    index_url = "http://health.businessweekly.com.tw/GSearchDoc.aspx?pro=0000&t=0&s=9&p=1"
    c = Crawler::Businessweekly.new
    c.fetch index_url
    c.crawl_bw_doctors_url

    expect(Doctor.count).to be > 1

    doctor = Doctor.last
    expect(doctor.bUrl).not_to be nil
    expect(doctor.name).not_to be nil
    expect(doctor.address).not_to be nil
  end

  it "crawl name" do
    expect(@doc.name).to eq("林逸民")
  end

  it "crawl division" do
    expect(@doc.divisions[0].name).to eq("眼科")
  end

  it "crawl doctor's hospital" do
    expect(@doc.hospitals[0].name).to eq("五福診所")
    # expect(@doc.hospitals.count).to be > 0
  end

  it "crawl hospital detail if hospital not exist" do
    @hosp = @doc.hospitals[0]
    expect(@hosp.address).not_to be nil
    expect(@hosp.name).not_to be nil
  end

  it "crawl doctor's phone" do
    expect(@doc.phone).to eq("03-9542344")
  end

  it "crawl doctor's address" do
    expect(@doc.address).to eq("宜蘭縣羅東鎮中正路108號")
  end

  it "crawl specialty" do
    expect(@doc.spe).to eq("白內障、青光眼、眼科疑難雜症")
  end

  it "crawl experience" do
    expect(@doc.exp).to eq("北醫台大長庚臨床教授、美國眼科及外科學院院士、Woodriver Township Hospital醫師")
  end

end
