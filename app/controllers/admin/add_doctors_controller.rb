class Admin::AddDoctorsController < Admin::AdminController

  def index
    @doctors = AddDoctor.all
  end
end
