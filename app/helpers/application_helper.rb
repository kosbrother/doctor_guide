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

  def findDoctorDivName(dr_id)
    Doctor.find(dr_id).divisions[0].name
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
