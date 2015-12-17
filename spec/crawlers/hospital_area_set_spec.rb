require 'rails_helper'
require 'classes/hospital_area_set'

describe "hospital_area_set" do
  it "convert area by address" do
    setter = HospitalAreaSet.new
    expect(setter.convert("台北市信義區吳興街２５２號")).to eq("臺北市")
    expect(setter.convert("新北市淡水區民生路４５號")).to eq("新北市")
    expect(setter.convert("桃園市龜山區公西里復興街5號")).to eq("桃園市")
    expect(setter.convert("台中市北區育德路２號")).to eq("臺中市")
    expect(setter.convert("台南市北區勝利路１３８號")).to eq("臺南市")
    expect(setter.convert("高雄市左營區大中一路３８６號")).to eq("高雄市")

    expect(setter.convert("基隆市安樂區麥金路２２２號基金一路２０８巷２００號")).to eq("基隆市")
    expect(setter.convert("新竹市北區中山路１８３號")).to eq("新竹市")
    expect(setter.convert("嘉義市西區新民路８８號")).to eq("嘉義市")

    expect(setter.convert("新竹縣竹東鎮至善路５２號")).to eq("新竹縣")
    expect(setter.convert("苗栗縣竹南鎮民治街１７號")).to eq("苗栗縣")
    expect(setter.convert("彰化縣二林鎮豐田里大成路一段５１號")).to eq("彰化縣")
    expect(setter.convert("南投縣中寮鄉永平村永安街１８８號")).to eq("南投縣")
    expect(setter.convert("雲林縣土庫鎮中山路６４號")).to eq("雲林縣")
    expect(setter.convert("嘉義縣大林鎮平林里民生路２號")).to eq("嘉義縣")
    expect(setter.convert("屏東縣潮州鎮朝昇路３２２號")).to eq("屏東縣")
    expect(setter.convert("宜蘭縣宜蘭市新民路１５２號")).to eq("宜蘭縣")
    expect(setter.convert("花蓮縣花蓮市中央路３段７０７號")).to eq("花蓮縣")
    expect(setter.convert("臺東縣台東市中正路３３４號")).to eq("臺東縣")
    expect(setter.convert("澎湖縣馬公市大仁街６號")).to eq("澎湖縣")

    expect(setter.convert("桃園縣中壢市中央東路23號1樓(臺北市新生南路1段161巷2號8F之1)")).to eq("桃園市")
    expect(setter.convert("屏東市大武里大武路２５號")).to eq("屏東縣")
    expect(setter.convert("花蓮市民權路４４號")).to eq("花蓮縣")
    expect(setter.convert("南投市復興路３７３號")).to eq("南投縣")
  end

  it "set the hospital area info" do
    Area.create(name: "臺北市")

    h = Hospital.new
    h.address = "台北市信義區吳興街２５２號"

    setter = HospitalAreaSet.new
    setter.set_hospital(h)

    expect(h.area.name).to eq("臺北市")
  end
end