class ApplicationController < ActionController::Base
 protect_from_forgery 
 before_filter :mailer_set_url_options
 before_filter :authenticate_user!
 before_filter :reset_sessions
 
 
  def mailer_set_url_options
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
  
  def reset_sessions
    if params[:auth_token]
      reset_session
    end
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  def current_uri
    request.env['PATH_INFO']
  end
  
end
