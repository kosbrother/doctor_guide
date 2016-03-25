require 'uri'

class SearchController < ApplicationController

  def search
    if request.post?
      url = "/search?search=#{params['search']}"
      encoded_url = URI.encode(url)
      redirect_to   URI.parse(encoded_url).to_s
    elsif request.get?
      @hospitals = Hospital.ransack(name_cont: params['search']).result.paginate(:page => params[:page]).per_page(10)
      @doctors = Doctor.ransack(name_cont: params['search']).result.paginate(:page => params[:page]).per_page(10)
    end
  end

end
