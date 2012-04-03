class Question < ActiveRecord::Base
  belongs_to :user
  
  before_save :capitalize_fields
  has_attached_file :opt1_image, :styles => { :medium => "180x180>", :thumb => "32x32>" }
  has_attached_file :opt2_image, :styles => { :medium => "180x180>", :thumb => "32x32>" }
  
  STATUSES = %w(waiting_approval approved deleted)
  
  validates_uniqueness_of :opt1, :scope => [:opt2]
  validates_presence_of :status , :opt1, :opt2
  validates_inclusion_of :status, :in => STATUSES
  
  def user_email
    self.user.email if !self.user.nil?
  end
  
  def capitalize_fields
    self.opt1=UnicodeUtils.titlecase(self.opt1)
    self.opt2=UnicodeUtils.titlecase(self.opt2)
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