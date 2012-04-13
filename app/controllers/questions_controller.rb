require 'fileutils'
class QuestionsController < ApplicationController
  # GET /questions
  # GET /questions.json
  load_and_authorize_resource
  skip_authorize_resource :only => :random
  
  def index
    if current_uri.include?('mine')
      @user=User.find(current_user)
      @questions = @user.questions
    elsif current_uri.include?('nopicture')
      @questions = Question.nopicture
    elsif current_uri.include?('wapproval')
      @questions = Question.all_wapproval
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
    profile=@user.profile
    profile.points=(@user.profile.points).to_i+(@question.points_for_create)
    @question.user_id=@user.id
   
    respond_to do |format|
      ActiveRecord::Base.transaction do
        @question.save!
        profile.save!
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render json:{:id=>@question.id,:points_gained=>@question.points_for_create,:points=>profile.points}, status: :created, location: @question }
      end      
    end
    
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved
      format.html { render action: "new" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
        
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
     if params[:auth_token]
       reset_session
     end
  
    @user = User.find(current_user)
    @question = Question.fresh(@user).active.pictured.random
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @question.to_json(:only=>[:id,:opt1,:opt1_image_file_name,:opt2,:opt2_image_file_name,:point]) }
    end
  end
  
  def image_migrate
    
    questions=Question.pictured
    strnotice="not migrated"
    
    questions.each do |question|
      begin
        filename=SecureRandom.hex(16)
        qid=question.id.to_s
        
        from_path=Rails.root.to_s+'/public/system/opt1_images/'+qid+'/original/'+question.opt1_image_file_name
        to_path=Rails.root.to_s+'/public/system/questions_images/'+filename+'_original.jpg'
        FileUtils.cp(from_path, to_path)
        
        from_path=Rails.root.to_s+'/public/system/opt1_images/'+qid+'/medium/'+question.opt1_image_file_name
        to_path=Rails.root.to_s+'/public/system/questions_images/'+filename+'_medium.jpg'
        FileUtils.cp(from_path, to_path)
        
        from_path=Rails.root.to_s+'/public/system/opt1_images/'+qid+'/thumb/'+question.opt1_image_file_name
        to_path=Rails.root.to_s+'/public/system/questions_images/'+filename+'_thumb.jpg'
        FileUtils.cp(from_path, to_path)
  
        question.update_attribute(:opt1_image_file_name,filename+".jpg")
        
        filename=SecureRandom.hex(16)
        from_path=Rails.root.to_s+'/public/system/opt2_images/'+qid+'/original/'+question.opt2_image_file_name
        to_path=Rails.root.to_s+'/public/system/questions_images/'+filename+'_original.jpg'
        FileUtils.cp(from_path, to_path)
        
        from_path=Rails.root.to_s+'/public/system/opt2_images/'+qid+'/medium/'+question.opt2_image_file_name
        to_path=Rails.root.to_s+'/public/system/questions_images/'+filename+'_medium.jpg'
        FileUtils.cp(from_path, to_path)
        
        from_path=Rails.root.to_s+'/public/system/opt2_images/'+qid+'/thumb/'+question.opt2_image_file_name
        to_path=Rails.root.to_s+'/public/system/questions_images/'+filename+'_thumb.jpg'
        FileUtils.cp(from_path, to_path)
  
        question.update_attribute(:opt2_image_file_name,filename+".jpg")
        
        puts "moved"+question.id.to_s
        rescue => e
          strnotice=strnotice+question.id.to_s+"-"
          next
        end
    end
      respond_to do |format|
        flash[:notice] = strnotice
        format.html { redirect_to wapproval_questions_url }
        format.json { head :no_content }
      end
  end
    
  def approve
    @question=Question.find(params[:id])
    @question.approve
    
    respond_to do |format|
      flash[:notice] = 'Question approved'
      format.html { redirect_to wapproval_questions_url }
      format.json { head :no_content }
    end
  end
  
end
