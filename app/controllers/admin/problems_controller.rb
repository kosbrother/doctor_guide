class Admin::ProblemsController < Admin::AdminController

  def index
    @problems = Problem.all
  end
end
