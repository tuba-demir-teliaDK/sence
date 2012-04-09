class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  
  validates_presence_of :user
  validates_presence_of :question
  
  default_scope :order => 'created_at desc'
  
end
