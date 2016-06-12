class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.authenticate(params[:session][:email], params[:session][:password])
  	if user.nil?
  		flash[:message] = "Invalid email or password"
  		redirect_to "/"
  	else
  		session[:user_id] = user.id
  		session[:alias] = user.alias
  		redirect_to '/ideas/index', notice: "You are logged in!"
  	end
  end

  def destroy
  	session.clear
  	redirect_to "/users/index"
  end
end
