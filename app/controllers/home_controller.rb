class HomeController < ApplicationController
  def index
      @question_count= Question.count
      @answer_count= Answer.count
      @user_count= User.count
      @nopicture_count=Question.nopicture.count
      @wapproval_count=Question.all_wapproval.count
      
      sql="select count(*) cnt, u.email,q.user_id from users u, questions q where u.id=q.user_id group by q.user_id"
      @user_questions = Question.find_by_sql([sql])
  end
end