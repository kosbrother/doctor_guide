class Admin::FeedbacksController < Admin::AdminController

  def index
    @feedbacks = Feedback.all
  end
end
