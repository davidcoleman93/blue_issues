class IssuesController < ApplicationController
#before_action :set_issue, only: [:show, :edit, :update, :destroy]
load_and_authorize_resource

  def index
	@issues = Issue.all
	#@issues = Issue.where.not(status: "Done")
	
	if params[:search]
		if params[:type] == "Title"
			@issues = Issue.search(params[:search]).order("created_at DESC")
		end
		if params[:type] == "Priority"
			@issues = Issue.priority_search(params[:search]).order("created_at DESC")
		end
		if params[:type] == "Status"
			@issues = Issue.status_search(params[:search]).order("created_at DESC")
		end
		if params[:type] == "Assignee"
			@issues = Issue.assignee_search(params[:search]).order("created_at DESC")
		end
	else
		@issues = Issue.order("created_at DESC")
    end
	
	#To display username(or other variables) of the User that created the issue(created_by).
	#@issues.each do |issue|
	#	test = issue.created_by
	@users = User.all
	#	@users.each do |user|
	#		if test == user.id
	#			@creatingUser = user
	#			break
	#		end
	#	end
	#end
  end
  
  def mytasks
	#@issues = Issue.where.not(status: "Done")
	#authorize! :create, Issue
	@allIssues = Issue.where.not(status: "Done")
	
	@issues = Array.new
	@notAccepted = Array.new
	
	for i in @allIssues
		if i.assigned_to == session[:user_id]
			if i.accepted == true
				@issues.push(i)
			else
				@notAccepted.push(i)
			end
		end
	end
	
  end
  
  def mypasttasks
	@allIssues = Issue.where(status: "Done")
	
	@issues = Array.new
	
	for i in @allIssues
		if i.assigned_to == session[:user_id]
			if i.accepted == true
				@issues.push(i)
			end
		end
	end
	
  end
  
  def myissues
	@allIssues = Issue.where.not(status: "Done")
	
	@issues = Array.new
	@notAccepted = Array.new
	
	for i in @allIssues
		if i.created_by == session[:user_id]
			if i.accepted == true
				@issues.push(i)
			else
				@notAccepted.push(i)
			end
		end
	end
  
  end
  
  def mypastissues
	@allIssues = Issue.where(status: "Done")
	
	@issues = Array.new
	
	for i in @allIssues
		if i.created_by == session[:user_id]
			if i.accepted == true
				@issues.push(i)
			end
		end
	end
  
  end
  
  def departmentissues
	currentManager = User.find_by(id: session[:user_id])
	#currentManager = User.find_by(id: 1)
	
	
	#currentDepartment = 2
	currentDepartment = currentManager.department_id
	
	@thisName = " "
	@issueCount = 0
	@totalHours = 0
	
	@issues = Issue.all
	#@users = User.where(department_id: 2)
	@users = User.where(department_id: currentDepartment)
	
	
	@departmentIssues = Array.new
	@unacceptedDeptIssues = Array.new
	
	for u in @users
		for i in @issues
			if i.assigned_to == u.id
				if i.status == "Done"
				
				else
					if i.accepted == true
						@departmentIssues.push(i)
					else
						@unacceptedDeptIssues.push(i)
					end
				end	
			end
		end
	end
	
	#departmentIssues = Array.new
	#for i in @issues
	#	if @currentDepartment = 
	#end
	
	 
  end
  
  def pastdepartmentissues
	currentManager = User.find_by(id: session[:user_id])
	#currentManager = User.find_by(id: 1)
	
	#currentDepartment = 2
	currentDepartment = currentManager.department_id
	
	@issues = Issue.all
	#@users = User.where(department_id: 2)
	@users = User.where(department_id: currentDepartment)
	
	
	@departmentIssues = Array.new
	
	for u in @users
		for i in @issues
			if i.assigned_to == u.id
				if i.status == "Done"
					@departmentIssues.push(i)
				end	
			end
		end
	end
	
  end

  
  def show
	@issue = Issue.find(params[:id])
	@posts = Post.where(issue_id: @issue.id)
	#currentIssue = @issue.id
	#current_Issue
	
	#User.find(params[:user_id]) = @issue.created_by
	#@issue.created_by = User.find(params[:user_id])
	#@creatingUser ||= User.find(params[user_id])
	#@creatingUser ||= User.find(params[@issue.created_by])
	
	#!!! FIXED IN VIEW INSTEAD OF CONTROLLER
	#To display username(or other variables) of the User that created the issue(created_by).
	#unless @issue.created_by.nil?
	#	test = @issue.created_by
		@users = User.all
	#	@users.each do |user|
	#		if test == user.id
	#			@creatingUser = user
	#			break
	#		end
	#	end
	#end
  end

  def new
  
  end
  
  def create
	@issue = Issue.new(issue_params)
	
	#@users = User.all
	#@user = User.find_by username: username if username.present?
	
	#@issue[:created_by] = @current_user[:user_id]
	#@issue.created_by = @current_user.user_id
	#@issue[:created_by] = @current_user[:id]
	@issue.created_by = session[:user_id]
	@issue.status = "Assigned"
	
	#@issue = current_user.issues.new(issue_params)
	#@issue.created_by = current_user
	
	#@department = Department.find(params[@issue.assigned_to])
	
	#The following 7 lines works perfectly.
	#They make it so an issue can be assigned to a dept. Doing this assigns it to the manager
	#of that dept.
	#@departments = Department.all
	#for i in @departments
	#	if @issue.assigned_to == i.id
	#		@issue.assigned_to = i.manager_id
	#		break
	#	end
	#end
	
	#below works perfectly
	
	#@assigneeDept = Department.find(@issue.assigned_to)  #Mainly for log entry after creation
	#@assigneeDeptName = @assigneeDept.dept_name
	
	@users = User.all
	@issues = Issue.all
	lowestHours = 1000000
	assigned_user = 0
	for u in @users
		if u.auto_assign == true
			if @issue.assigned_to == u.department_id
				currentUserHours = 0
				for i in @issues	#N.B Still need to make it so a "Done" or "Closed" issue isn't counted towards hours.
					if i.assigned_to == u.id
						if i.status == "Done"
						
						else
							currentUserHours = currentUserHours + i.time_to_complete
						end
					end
				end	#issues loop end
			
				if currentUserHours < lowestHours
					assigned_user = u.id
					lowestHours = currentUserHours
				end
				currentUserHours = 0
			end
		end
	end	#users loop endf1
	lowestHours = 0
	@issue.assigned_to = assigned_user
	#@issue.created_by = 1
	
	if @issue.save
		flash[:notice] = "Issue created successfully"
			logText = ""
			@currentAssignee = User.find(@issue.assigned_to)
			@issueCreator = User.find(@issue.created_by)
			@currentDept = Department.find(@currentAssignee.department_id)
			#varchar not the same as text?
			logText = "Issue created " + @issue.created_at.to_formatted_s(:long_ordinal)+ " by " + @issueCreator.username
			logText = logText + ". Issue assigned to " + @currentAssignee.username + " of the " + @currentDept.dept_name + " department. "
			logText = logText + @issue.priority + " priority. "
			@issue_log = @issue.issue_logs.create
			@issue_log.user_id = session[:user_id]
			#@issue_log.user_id = 1
			@issue_log.content = logText
			@issue_log.save
			
			
			IssueMailer.assigned(@issue).deliver
			@createdWatcher = @issue.watchers.create
			@createdWatcher.user_id = @issue.creator.id
			@createdWatcher.save
			@watcher = User.find_by(id: @createdWatcher.user_id)
			IssueMailer.changed(@issue, @watcher).deliver
			@assignedWatcher = @issue.watchers.create
			@assignedWatcher.user_id = @issue.assignee.id
			@assignedWatcher.save
			#IssueMailer.changed(@issue, @createdWatcher).deliver
			
			
		redirect_to(:action => "index")
	else
		render("new")
	end
 end

  def edit
	@issue = Issue.find(params[:id])
	@users = User.all
	
	#authorize! :update, @issue
  end
  
  def update
	@issue = Issue.find(params[:id])
	
	@before_title = @issue.title
	@before_priority = @issue.priority
	@before_summary = @issue.summary
	@before_status = @issue.status
	@before_created_by = @issue.created_by
	@before_assigned_to = @issue.assigned_to
	@before_hours = @issue.time_to_complete
	@before_accepted = @issue.accepted
	@before_active_issue = @issue.active_issue
	#@myIssues = Issue.where(status != "Done", assigned_to: session[:user_id]) #current_user.id)
	@allIssues = Issue.where.not(status: "Done")
	
	@issues = Array.new
	
	for i in @allIssues
		if i.assigned_to == session[:user_id]
				@issues.push(i)
		end
	end
	
	#if @issue.update_attributes(issue_params)
	#	if @issue.assigned_to == @before_assigned_to
	#
	#	else
	#		@issue.accepted = false
	#	end
	#end
	
	if @issue.update_attributes(issue_params)
		flash[:notice] = "Issue updated successfully"
		logText = ""
		
		#active user
		if @before_active_issue == @issue.active_issue
			
		else
			if @issue.active_issue == true
				for i in @issues
					if i.id == @issue.id
					
					else
						if i.active_issue == true
							#i.active_issue = false
							i.update_attributes(i.active_issue = false)
						end
					end
				end
			end
		end
		
		
		#title
		if @before_title == @issue.title
			
		else
			logText = logText + "Title changed from '" + @before_title + "' to '" + @issue.title + "'. "
			#redirect_to(:controller => "issue_logs", :action => "create")
		end
		
		#priority
		if @before_priority == @issue.priority
			
		else
			logText = logText + "Priority changed from '" + @before_priority + "' to '" + @issue.priority + "'. "
		end
		
		#summary
		if @before_summary == @issue.summary
			
		else
			logText = logText + "Summary changed from '" + @before_summary + "' to '" + @issue.summary + "'. "

		end
		
		#status
		if @before_status == @issue.status
			
		else
			logText = logText + "Status changed from '" + @before_status + "' to '" + @issue.status + "'. "
		end
		
		#created by
		if @before_created_by == @issue.created_by
			
		else
			#shouldn't happen in theory
			logText = logText + "Creator changed. "
			#logText = logText + "Created by changed from '" + @before_created_by + "' to '" + @issue.created_by + "'. "
		end
		
		#assigned to
		if @before_assigned_to == @issue.assigned_to
			
		else
			#@beforeAssignee = User.where(id: @before_assigned_to)
			#@afterAssignee = User.where(id: @issue.assigned_to)
			@beforeAssignee = User.find(@before_assigned_to)
			@afterAssignee = User.find(@issue.assigned_to)
			logText = logText + "Assignee changed from '" + @beforeAssignee.username + "' to '" + @afterAssignee.username + "'. "
			#logText = logText + "Assignee changed from '" + @before_assigned_to+ "' to '" + @issue.assigned_to + "'. "
		end
		
		#time to complete (hours)
		if @before_hours == @issue.time_to_complete
			
		else
			logText = logText + "Time to complete changed from '" + @before_hours.to_s + "' to '" + @issue.time_to_complete.to_s + "'. "
		end
		
		#accepted
		if @before_accepted == @issue.accepted
			
		else
			if @issue.accepted == true
				@currentAssignee = User.find(@issue.assigned_to)
				logText = logText + "Issue accepted by " + @currentAssignee.username
			else
				logText = logText + "Issue not accepted"
			end
			#logText = "Accepted changed from '" + @before_accepted+ "' to '" + @issue.accepted + "'."
		end
		
		if logText == ""
			#So no log entry will be made if update is clicked but no actual changes were made
		else
			@issue_log = @issue.issue_logs.create
			@issue_log.user_id = session[:user_id]
			#@issue_log.user_id = 1
			@issue_log.content = logText
			@issue_log.save
			@watchers = @issue.watchers
			for w in @watchers
				@watcher = User.find_by(id: w.user_id)
				IssueMailer.changed(@issue, @watcher).deliver
			end
		end	
		
		redirect_to(:action => "show", :id => @issue.id)
	else
		render("edit")
	end
  end


  def delete
	@issue = Issue.find(params[:id])
  end
  
  def destroy
	@issue = Issue.find(params[:id])
	@issue.destroy
	flash[:notice] = "Issue destroyed successfully"
	redirect_to(:action => "index")
  end
  
  private
	def issue_params
	#same as using “params[:issue]”, except that it:
	# - raises an error if :issue is not present
	# - allows listed attributes to be mass-assigned
		params.require(:issue).permit(:id, :title, :priority, :summary, :status, :created_by, :assigned_to, :assigned_username, :time_to_complete, :accepted, :active_issue)
	end
	
	#def set_issue
	#	@issue = Issue.find(params[:id])
	#end
	
end
