class SessionsController < Devise::SessionsController
  prepend_before_filter :require_no_authentication, :only => [ :new, :create ]
  prepend_before_filter :allow_params_authentication!, :only => :create
  
  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)

    respond_to do |format|
      format.html do
        respond_with resource, :location => redirect_location(resource_name, resource)
      end
      format.json do
        render :json => { :response => 'ok', :auth_token => current_user.authentication_token }.to_json, :status => :ok
      end
    end
  end
end 