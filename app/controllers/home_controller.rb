class HomeController < ApplicationController
   
  def index
      @totalcount= Question.count
      
      sql="select count(*) cnt, u.email from users u, questions q where u.id=q.user_id group by q.user_id"
      
      @questions = Question.find_by_sql([sql])
  end

end