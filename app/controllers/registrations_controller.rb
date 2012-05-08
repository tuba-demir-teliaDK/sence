class RegistrationsController < Devise::RegistrationsController

  def create
    user= User.find_by_apple_id(params["user"]["apple_id"])
    paramemail=params["user"]["email"]
    paramemail_by_appleid = params["user"]["apple_id"].to_s + "@igones.com"
    
    respond_to do |format|  
      format.html { 
        super 
      }
      format.json {
        build_resource
        if user.nil?
          if resource.save
             render :status => 200, :json => resource.to_json(:only=> :authentication_token)
          else
            render :json => resource.errors, :status => :unprocessable_entity
          end
        elsif !user.nil? and user.email==paramemail and paramemail==paramemail_by_appleid
            render :status => 200, :json => user.to_json(:only=> :authentication_token)
        else
            render :json => "server error", :status => :unprocessable_entity
        end
      }
    end
   end
   
  def new
    flash[:info] = 'Registrations are not open yet, but please check back soon'
    redirect_to user_session_path
  end
end