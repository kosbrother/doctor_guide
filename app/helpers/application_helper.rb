module ApplicationHelper
  def pagination_links(collection, options = {})
    options[:renderer] ||= BootstrapPaginationHelper::LinkRenderer
    options[:class] ||= 'pagination pagination-centered'
    options[:inner_window] ||= 2
    options[:outer_window] ||= 1
    options[:previous_label] = '<'
    options[:next_label] = '>'
    will_paginate(collection, options)
  end

  def findDivName(div_id)
    Division.find(div_id).name
  end


  def findDoctorDivName(dr_id)
    Doctor.find(dr_id).divisions[0].name
  end

  def findDoctor(dr_id)
    DivHospDocShip.find_by(doctor_id: dr_id)
  end

  def findDocHospId(dr_id)
    result = findDoctor(dr_id)
    result.hospital_id
  end



  def findDocDivId(dr_id)
    result = findDoctor(dr_id)
    result.division_id
  end

  def tellGrade(grade)
    case grade
      when '診所'
        1
      when '地區醫院'
        2
      when '區域醫院'
        3
      when '醫學中心'
        4
      else
        2
    end
  end
end
