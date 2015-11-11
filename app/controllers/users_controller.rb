class UsersController < ApplicationController
  load_and_authorize_resource
  def index
	@users = User.all
	
	if params[:search]
		if params[:type] == "First Name"
			@users = User.firstname_search(params[:search]).order("created_at DESC")
		end
		if params[:type] == "Last Name"
			@users = User.lastname_search(params[:search]).order("created_at DESC")
		end
		if params[:type] == "Title"
			@users = User.title_search(params[:search]).order("created_at DESC")
		end
		if params[:type] == "Username"
			@users = User.username_search(params[:search]).order("created_at DESC")
		end
	else
		@users = User.order("created_at DESC")
    end
  end

  def show
	@user = User.find(params[:id])
	#authorize! :read, @user
  end

  def new
	
  end

  def create
	@user = User.new(user_params)
	
	if @user.save
		flash[:notice] = "User created successfully"
		redirect_to(:action => "index")
	else
		render("new")
	end
  end


  def edit
	@user = User.find(params[:id])
	#authorize! :update, @user
  end
  
  def update
	@user = User.find(params[:id])
	if @user.update_attributes(user_params)
		flash[:notice] = "User updated successfully"
		redirect_to(:action => "show", :id => @user.id)
	else
		render("edit")
	end
  end
  
  def delete
	@user = User.find(params[:id])
  end
  
  def destroy
	@user = User.find(params[:id])
	@user.destroy
	flash[:notice] = "User destroyed successfully"
	redirect_to(:action => "index")
  end
  
  private
	def user_params
	#same as using “params[:user]”, except that it:
	# - raises an error if :user is not present
	# - allows listed attributes to be mass-assigned
		params.require(:user).permit(:first_name, :last_name, :title, :username, :password, :password_confirmation, :email, :DOB, :phone_number, :department_id, :admin, :manage, :normal, :basic, :auto_assign)
	end


end
