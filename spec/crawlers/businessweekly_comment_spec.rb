require 'rails_helper'
require 'classes/crawler'
require 'classes/crawler/businessweekly'

describe "businessweekly_crawler" do

  before(:all){
    @doc = Doctor.create(bUrl: "http://health.businessweekly.com.tw/IDoctor.aspx?id=DOC0000002951")
    @c = Crawler::Businessweekly.new
    @c.fetch @doc.bUrl
    @c.crawl_comment @doc
  }

  it "crawl comment" do
    expect(@doc.comments.size).to be > 1
  end

  it "crawl comment date" do
    expect(@doc.comments[0].comment_date).to eq("2015/11/06")
  end

  it "crawl commentor" do
    expect(@doc.comments[0].commentor.name).to eq("吳玟娟")
  end

end
