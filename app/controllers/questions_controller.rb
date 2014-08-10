class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy, :answer, :answerd]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.where(to: current_user.email)
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  def answer
  end

  def answerd
    if params[:answer] == "yes"
      answer = true
    else
      answer = false
    end

    flash[:notice] = "回答を送信しました"

    @question.update_columns(answer: answer, answerd: true)

    render 'user/index'
  end
  
  def sends
    @questions = Question.where(from: current_user.email)
  end

  # GET /questions/new
  def new
    @question = Question.new
    @question.to = params[:to]
    @question.from = current_user.email
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    @question.from = current_user.email


    @user = User.find_by(email: @question.from)

    
    registration_id = "APA91bGLmtgSCFXLTOKSetLQLeOAeExnFnho7FUHfJdM7VMkcoaTEFiSq4vzT17ouTuB3jzIPt9w-goWLHmgpsmu5bk5lVRO2svtYdJPQsKrTGQpAFzqNEvd_F-4wACpoMnXRUYjBV74OScEkuQEmXTGz0ag5P7niQ"
    #destination = [@user.reg_id]
    string = "" + @user.email + "から送信されました"
    data = { message: string }
    destination = Array.new
    destination = [registration_id]

    GCM.send_notification( destination, data )


    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: '質問が送信されました' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.jso
  def update
    @question.answerd = true

    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to "/", notice: '質問が削除されました' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:to, :from, :question, :answer, :answerd?)
    end
end
