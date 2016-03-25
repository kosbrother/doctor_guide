class CommentsController < ApplicationController
  def show
    @comment = Comment.find(params['id'])
    if params['doctor_id']
      @doctor = Doctor.find(params['doctor_id'])
    else

    end
    @hospital = Hospital.find(params['hospital_id'])
    @division = Division.find(params['division_id'])

  end
end
