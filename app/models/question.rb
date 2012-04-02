class Question < ActiveRecord::Base
  belongs_to :user
  
  STATUSES = %w(waiting_approval approved deleted)
  
  validates_uniqueness_of :opt1, :scope => [:opt2]
  validates_presence_of :status 
  validates_inclusion_of :status, :in => STATUSES
  
  def user_email
    self.user.email if !self.user.nil?
  end
  
  def capitalize_fields
    self.opt1=self.opt1.capitalize
    self.opt2=self.opt2.capitalize
  end
  
  class << self 
    STATUSES.each do |status_name|
      define_method "all_#{status_name}" do
        where(:status => status_name)
      end 
    end
  end
  
  # Status Accessors
  STATUSES.each do |status_name| 
    define_method "#{status_name}?" do
      status == status_name 
    end
  end
  
end