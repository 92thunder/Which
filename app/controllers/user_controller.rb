class UserController < ApplicationController
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
end
