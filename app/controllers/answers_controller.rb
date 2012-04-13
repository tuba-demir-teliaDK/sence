class AnswersController < ApplicationController
  # GET /answers
  # GET /answers.json
  load_and_authorize_resource
  skip_authorize_resource :only => :history
  def index
    @answers = Answer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @answers }
    end
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
    @answer = Answer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @answer }
    end
  end

  # GET /answers/new
  # GET /answers/new.json
  def new
    @answer = Answer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @answer }
    end
  end

  # GET /answers/1/edit
  def edit
    @answer = Answer.find(params[:id])
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(params[:answer])
    @user = User.find(current_user)
    @answer.user_id=@user.id
    @question = Question.find(@answer.question_id)
    profile=@user.profile
    profile.points=(@user.profile.points).to_i+(@question.point)
    
    if @answer.opt==1
      @question.opt1_ac= (@question.opt1_ac).to_i + 1
    else
      @question.opt2_ac= (@question.opt2_ac).to_i + 1
    end
    
    respond_to do |format|
      ActiveRecord::Base.transaction do
        @answer.save!
        @question.save!
        profile.save!
        format.html { redirect_to @answer, notice: 'Answer was successfully created.' }
        #format.json { render json: [@question.to_json(:only=> [:opt1_ac,:opt2_ac]),profile.to_json(:only=>:points)], status: :created, location: @answer }
        format.json { render json:{:opt1_ac=>@question.opt1_ac,:opt2_ac=>@question.opt2_ac,:points_gained=>@question.point,:points=>profile.points}, status: :created, location: @answer }
      end      
    end
    
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved
      format.html { render action: "new" }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
   end

  # PUT /answers/1
  # PUT /answers/1.json
  def update
    @answer = Answer.find(params[:id])

    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        format.html { redirect_to @answer, notice: 'Answer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to answers_url }
      format.json { head :no_content }
    end
  end
  
  def history
    @user = User.find(current_user)
    
    sql="select q.opt1,q.opt2,q.point,a.opt, a.created_at,q.opt1_ac, q.opt2_ac from questions q, answers a 
         where q.id=a.question_id and a.user_id=? order by a.created_at asc"
         
    @answers = Answer.find_by_sql([sql,@user.id])
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @answers }
      end
  end
end
