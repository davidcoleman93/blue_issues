class SessionsController < ApplicationController  
  #before_action :current_user?
  #load_and_authorize_resource, only: :index
  
  def new
  end
  
  def index
	authorize! :create, Issue
  end
  
  def create
	user = User.find_by username: params[:username]
	if user && user.authenticate(params[:password])
		# sign in
		session[:user_id] = user.id
		flash[:notice] = "You are signed in!"
		redirect_to root_url
	else
		flash.now[:notice] = "Invalid email/password."
		render 'new'
	end
  
end  
  
  def destroy
	session[:user_id] = nil
	flash[:notice] = "You are now signed out"
	redirect_to root_url
  end
end

