class AddDoctorsController < ApplicationController

  def index
    @doctors = AddDoctor.all
  end
end
