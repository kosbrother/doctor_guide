require 'uri'

class SearchController < ApplicationController

  def search
    if request.post?
      url = "/search?#{params['search']}"
      encoded_url = URI.encode(url)
      redirect_to   URI.parse(encoded_url).to_s
    elsif request.get?
      @h = Hospital.ransack(params['search'])
      @d = Doctor.ransack(params['search'])
      @hospitals = @h.result(distinct: true)
      @doctors = @d.result(distinct: true)
    end
  end

end
