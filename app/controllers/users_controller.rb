class UsersController < ApplicationController
  
  def new
    p params
  end

  def create
    p params
    @user = User.new(user_params)
    if @user.save
      
    else
      render "new", status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
    
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
