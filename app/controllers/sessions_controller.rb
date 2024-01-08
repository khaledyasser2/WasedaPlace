class SessionsController < ApplicationController
  def new
    
  end

  
  def create
    @user = User.find(user_params)
    if @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render "new", status: :unprocessable_entity
    end
  end
  
end
