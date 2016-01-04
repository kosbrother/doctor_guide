# encoding: UTF-8
class Api::ApiController  < ActionController::Base
  before_filter :check_format_json
  
  def check_format_json
    if request.format != :json
        render :status=>406, :json=>{:message=>"The request must be json"}
        return
    end
  end

  def status_check
    render :status=>200, :json=>{:message=>"The request ok "}
  end

end