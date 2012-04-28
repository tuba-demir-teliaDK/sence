class Category < ActiveRecord::Base
  has_many :questions

  default_scope :order => 'name'
  
end
