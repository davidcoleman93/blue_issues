class WatchersController < ApplicationController
	load_and_authorize_resource :issue
	load_and_authorize_resource :through => :issue

	skip_authorize_resource :only => :show  
	skip_authorize_resource :issue, :only => :show
	def create
		@issue = Issue.find params[:issue_id]	#WORKS BUT EDIT/DELETE BROKEN
		@watcher = @issue.watchers.new(watcher_params)	#WORKS BUT EDIT/DELETE BROKEN
		
		#params[:issues][:id].each do |issue|
		#	if !issue.empty?
		#		@watcher.
		#	end
		#end
		
		#@watcher.user_id = session[:user_id]
		@checkwatcher = @issue.watchers.where(user_id: @watcher.user_id)
		#for w in @issue.watchers.all
			if @checkwatcher.empty?
			#if w.user_id == @watcher.user_id
				#dont do it. Watcher already exists.
				@watcher.save					#saves the @watcher 					
								#object to the posts table
				flash[:notice] = "Watcher added successfully"
				respond_to do |format|
					format.html { redirect_to @issue }
				end
			else
				flash[:notice] = "User already a watcher"
				respond_to do |format|
					format.html { redirect_to @issue }
				end
			end
		#end
	end
	
	def destroy
		@issue = Issue.find(params[:issue_id])
		@watcher = @issue.watchers.find(params[:id])
		@watcher.destroy
		flash[:notice] = "Watcher destroyed successfully"
		redirect_to issue_path(@issue)
    end
	
	
	private
		def watcher_params
		#same as using “params[:watcher]”, except that it:
		# - raises an error if :watcher is not present
		# - allows listed attributes to be mass-assigned
			params.require(:watcher).permit(:user_id, :issue_id) if params[:watcher]
		end
end
