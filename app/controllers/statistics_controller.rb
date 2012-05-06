class StatisticsController < ApplicationController
  # GET /questions
  # GET /questions.json
  skip_authorize_resource :only => :random
  
  
  def most_answered
    sql="select * from (select opt1_ac+opt2_ac tc,id,opt1,opt2,opt1_ac,opt2_ac from questions) x order by tc desc"
    
    @mostanswered=Question.find_by_sql(sql).first
  
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mostanswered.to_json(:except=>[:tc]) }
    end
  end
  
end
