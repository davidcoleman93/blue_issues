class IssueLogsController < ApplicationController

def create
     @issue = Issue.find params[:issue_id]
     #@post = @issue.posts.create params[:post]
	 @issue_log = @issue.issue_logs.new(issue_log_params)
     #@post.user_id = @current_user.id		#sets the user_id FK
	 #@issue_log.user_id = session[:user_id]
	 @issue_log.user_id = 1
     @issue_log.save					#saves the @issue_log 					
								#object to the issue_logs table
	respond_to do |format|
		format.html { redirect_to @issue }
    end
end

 private
	def issue_log_params
	#same as using “params[:issue_log]”, except that it:
	# - raises an error if :issue_log is not present
	# - allows listed attributes to be mass-assigned
		params.require(:issue_log).permit(:id, :content, :user_id, :issue_id)
	end

end
