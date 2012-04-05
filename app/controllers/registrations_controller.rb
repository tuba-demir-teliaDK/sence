class RegistrationsController < Devise::RegistrationsController

  def create
    respond_to do |format|  
      format.html { 
        super 
      }
      format.json {
        build_resource
        if resource.save
           render :status => 200, :json => resource.to_json(:only=> :authentication_token)
        else
          render :json => resource.errors, :status => :unprocessable_entity
        end
      }
    end
   end
 

end