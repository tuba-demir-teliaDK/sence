class CategoryQuestionsController < ApplicationController
  # GET /category_questions
  # GET /category_questions.json
  def index
    @category_questions = CategoryQuestion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @category_questions }
    end
  end

  # GET /category_questions/1
  # GET /category_questions/1.json
  def show
    @category_question = CategoryQuestion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category_question }
    end
  end

  # GET /category_questions/new
  # GET /category_questions/new.json
  def new
    @category_question = CategoryQuestion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category_question }
    end
  end

  # GET /category_questions/1/edit
  def edit
    @category_question = CategoryQuestion.find(params[:id])
  end

  # POST /category_questions
  # POST /category_questions.json
  def create
    @category_question = CategoryQuestion.new(params[:category_question])

    respond_to do |format|
      if @category_question.save
        format.html { redirect_to @category_question, notice: 'Category question was successfully created.' }
        format.json { render json: @category_question, status: :created, location: @category_question }
      else
        format.html { render action: "new" }
        format.json { render json: @category_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /category_questions/1
  # PUT /category_questions/1.json
  def update
    @category_question = CategoryQuestion.find(params[:id])

    respond_to do |format|
      if @category_question.update_attributes(params[:category_question])
        format.html { redirect_to @category_question, notice: 'Category question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /category_questions/1
  # DELETE /category_questions/1.json
  def destroy
    @category_question = CategoryQuestion.find(params[:id])
    @category_question.destroy

    respond_to do |format|
      format.html { redirect_to category_questions_url }
      format.json { head :no_content }
    end
  end
end
