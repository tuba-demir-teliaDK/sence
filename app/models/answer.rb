class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  
  validates_presence_of :user
  validates_presence_of :question
  validates_uniqueness_of :question_id, :scope => [:user_id] 
  
  default_scope :order => 'created_at desc'

end
