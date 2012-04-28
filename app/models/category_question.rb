class CategoryQuestion < ActiveRecord::Base
  belongs_to :category
  belongs_to :question
  
  validates_presence_of :category
  
  validates_uniqueness_of :category_id, :scope => [:question_id]
  
  delegate :name, :to => :category, :prefix=> true
  delegate :name, :to => :question, :prefix=> true
  
end
