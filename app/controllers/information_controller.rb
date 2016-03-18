class InformationController < ApplicationController
  def hospital
    hospital_id = params['hospital']
    @hospital = Hospital.find(hospital_id)
  end

  def category
    @categories = Category.all
  end

  def doctor

  end
end
