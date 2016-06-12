class UsersController < ApplicationController
  def index
  	@user = User.new
  end

  def create
  	@user = User.new(users_params)
    if @user.save
      flash[:notice] = 'Registration successful, please log in'
      redirect_to '/'
    else
 	  flash[:error] = "Registration failed, #{@user.errors.full_messages}"
      redirect_to '/'
    end
  end
  def show
  	@user = User.find(params[:id])
  end

  private
  def users_params
  	params.require(:user).permit(:name,:alias,:email,:password,:confirm_password)
  end
end
