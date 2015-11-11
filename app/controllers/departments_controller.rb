class DepartmentsController < ApplicationController
  load_and_authorize_resource
  def index
	@departments = Department.all
  end

  def show
	@department = Department.find(params[:id])
  end

  def new
  
  end

  def create
	@department = Department.new(department_params)
	
	if @department.save
		flash[:notice] = "Department created successfully"
		redirect_to(:action => "index")
	else
		render("new")
	end
  end
  
  def edit
	@department = Department.find(params[:id])
  end
  
  def update
	@department = Department.find(params[:id])
	if @department.update(department_params)
		flash[:notice] = "Department updated successfully"
		redirect_to(:action => "show", :id => @department.id)
	else
		render("edit")
	end
  end  
  
  def delete
	@department = Department.find(params[:id])
  end
  
  def destroy
	@department = Department.find(params[:id])
	@department.destroy
	flash[:notice] = "Department destroyed successfully"
	redirect_to(:action => "index")
  end
  
   private
	def department_params
	#same as using “params[:department]”, except that it:
	# - raises an error if :department is not present
	# - allows listed attributes to be mass-assigned
		params.require(:department).permit(:dept_name, :manager_id)
	end
end
