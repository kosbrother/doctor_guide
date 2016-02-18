require 'rails_helper'

describe Comment do
  it { should have_db_column :doctor_id }
  it { should have_db_column :hospital_id }
  it { should have_db_column :division_id }
  it { should have_db_column :dr_friendly }
  it { should have_db_column :dr_speciality }
  it { should have_db_column :div_equipment }
  it { should have_db_column :div_environment }
  it { should have_db_column :div_speciality }
  it { should have_db_column :div_friendly }
  
  it { should have_db_index :doctor_id }
  it { should have_db_index :hospital_id }
  it { should have_db_index :division_id }

  describe "after create" do
    it "should update doctor and hospital score" do
      doctor = Doctor.create
      division = Division.create
      hospital = Hospital.create

      ship = DivHospDocShip.new
      ship.hospital = hospital
      ship.division = division

      doctor.div_hosp_doc_ships << ship

      c = Comment.new
      c.dr_friendly = 0
      c.dr_speciality = 1
      c.div_equipment = 1
      c.div_environment = 1
      c.div_speciality = 1
      c.div_friendly = 1
      c.doctor = doctor
      c.hospital = hospital
      c.division = division
      c.save

      doctor = Doctor.first
      expect(doctor.comment_num).to eq(1)
      expect(doctor.recommend_num).to eq(0)
      expect(doctor.avg.round(2).to_s).to eq("0.5")
      hospital = Hospital.first
      expect(hospital.comment_num).to eq(1)
      expect(hospital.recommend_num).to eq(0)
      expect(hospital.avg.round(2).to_s).to eq("1.0")
    end
  end
end