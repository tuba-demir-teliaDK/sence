class StatisticsController < ApplicationController
  # GET /questions
  # GET /questions.json
  authorize_resource :class => false  
  
  def most_answered
    sql="select * from (select opt1_ac+opt2_ac tc,id,opt1,opt2,opt1_ac,opt2_ac from questions) x order by tc desc LIMIT 0, 10"
    
    @mostanswered=Question.find_by_sql(sql)
  
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mostanswered.to_json(:except=>[:tc]) }
    end
  end
  
  def gap
    sql="select * from (select abs(((opt1_ac/opt1_ac+opt2_ac)*100)-((opt2_ac/opt1_ac+opt2_ac)*100)) tc,id,opt1,opt2,opt1_ac,opt2_ac from questions) x where tc<>100 order by tc desc LIMIT 0, 10"
    @gap=Question.find_by_sql(sql)
  
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gap.to_json(:except=>[:tc]) }
    end  
  end
  
  def aomq
    @user = User.find(current_user)
    sql="select * from questions where user_id=? order by created_at desc"
    
    @aomq=Question.find_by_sql([sql,@user.id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @aomq.to_json(:only=>[:id,:opt1,:opt2,:opt1_ac,:opt2_ac,:status,:opt1_image_file_name,:opt2_image_file_name]) }
    end
  end
  
end
