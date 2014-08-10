class UserController < ApplicationController
  #skip_before_action :verify_authenticity_token, only: [:register]

  def index
    @users = User.all
  end

  def find
    @questions = Question.where(from: current_user.email)
    @questions = @questions.reverse
    @questions.uniq! { |question| question.to }


    @to = params[:to]
    if User.exists?(email: @to)
      @valid = true
    else
      @valid = false
    end
    render
  end

  def setting
  end

  def register
    reg_id = params[:reg_id]
    email = params[:email]
    password = params[:pw]
    @user = User.create!(
      email: email,
      password: password,
      reg_id: reg_id
    )
    render text: "success"
  rescue ActiveRecord::RecordInvalid => e
    @user = e.record
    render text: @user
  end
end
