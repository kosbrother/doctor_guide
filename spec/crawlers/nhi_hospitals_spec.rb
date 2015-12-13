require 'rails_helper'
require 'classes/crawler'
require 'classes/crawler/nhi'

describe "nhi_hospitals" do

  before(:all){
    @c = Crawler::Nhi.new
    @c.post_fetch("http://www.nhi.gov.tw/Query/query3_list.aspx",{SpecialCode: 1, PageNum: 10})
  }

  it "contain hospital link" do
    links = @c.page_html.css('[id*="lblHospName"] a')
    expect(links.size).to be > 0
  end

  it "write nhiUrl to hospital db" do
    @c.crawle_hospital_urls
    hospital = Hospital.last

    expect(hospital).not_to be nil
    expect(hospital.nhiUrl).not_to be nil
    expect(hospital.on).not_to be nil
  end

end