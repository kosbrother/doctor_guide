class IndexController < ApplicationController
  def index
    @areas = Area.all
    @divisions = Division.all
    @hospitals = Hospital.all
    @doctors = Doctor.all
    @comments = Comment.all

  end
end
