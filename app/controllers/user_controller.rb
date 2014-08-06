class UserController < ApplicationController
  def index
    @users = User.all
  end
  def find
    @to = params[:to]
    if User.exists?(email: @to)
      @valid = true
    else
      @valid = false
    end
    render
  end
end
