class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #include AccessHelper
  
  helper_method :current_user
  
  rescue_from CanCan::AccessDenied do |exception|
		flash[:notice] = "Access denied."
		redirect_to root_url
  end
	
  private

  #Makes current_user available in all controllers
  def current_user
	User.find_by id: session[:user_id] if session[:user_id]
  end
end
