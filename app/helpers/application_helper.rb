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

  def pagination_links_dot(collection, options = {})
    options[:renderer] ||= BootstrapPaginationHelper::DotLinkRenderer
    options[:class] ||= 'division-pagination pagination-centered'
    options[:inner_window] ||= 2
    options[:outer_window] ||= 1
    will_paginate(collection, options)
  end
end
