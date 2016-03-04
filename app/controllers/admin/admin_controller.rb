class Admin::AdminController < ApplicationController
  layout 'admin/admin'

  before_filter :authenticate

  USER_ID   = "DoctorAdmin"
  PASSWORD  = "DoctorGuideApp"
  protected
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == USER_ID && password == PASSWORD
      end
    end
    
end
