class SearchController < ApplicationController
  def search_doctors
    if params[:q].nil?
      @doctors = []
    else
      @doctors = Doctor.search params[:q]
    end
  end
  def search_hospitals
    if params[:q].nil?
      @hospitals = []
    else
      @hospitals = Hospital.search params[:q]
    end
  end  
end
