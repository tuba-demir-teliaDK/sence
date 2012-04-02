class Question < ActiveRecord::Base
  belongs_to :user
  
  def user_email
    self.user.email if !self.user.nil?
  end
end
