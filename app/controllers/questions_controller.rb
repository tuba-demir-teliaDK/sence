class QuestionsController < ApplicationController
  # GET /questions
  # GET /questions.json
  def index
    
    if current_uri.include?('mine')
      @user=User.find(current_user)
      @questions = @user.questions
    elsif current_uri.include?('nopicture')
      @questions = Question.nopicture
    elsif params[:user_id]
      @user=User.find(params[:user_id])
      @questions = @user.questions
    else
      @questions = Question.all
    end
    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @questions }
    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @question = Question.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @question }
    end
  end
  
  def stats
    @question=Question.find(params[:id])
    
    respond_to do |format|
      format.json{render json:@question.to_json(:only=>[:opt1_ac,:opt2_ac])}
    end
    
  end

  # GET /questions/new
  # GET /questions/new.json
  def new
    @question = Question.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  # POST /questions.json
  def create
    @user = User.find(current_user)
    @question = Question.new(params[:question])
    @question.user_id=@user.id

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render json: @question, status: :created, location: @question }
      else
        format.html { render action: "new" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.json
  def update
    @question = Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      if current_uri.include?('mine')
        format.html { redirect_to mine_questions_url }
      else
        format.html { redirect_to questions_url }
      end
      
      format.json { head :no_content }
    end
  end
  
   def random
    @user = User.find(current_user)
    @question = Question.fresh(@user).active.random
    
    puts @question
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @question }
    end
  end
  
end
