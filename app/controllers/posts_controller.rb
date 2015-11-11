class PostsController < ApplicationController
#before_action :set_issue
#load_and_authorize_resource :nested => :issue //doesn't work
load_and_authorize_resource :issue
load_and_authorize_resource :through => :issue

skip_authorize_resource :only => :show  
skip_authorize_resource :issue, :only => :show

def create
     @issue = Issue.find params[:issue_id]	#WORKS BUT EDIT/DELETE BROKEN
	 #@issue = Issue.find(params[:id])
	 #@issue = Issue.current
     #@post = @issue.posts.create params[:post]
	 @post = @issue.posts.new(post_params)	#WORKS BUT EDIT/DELETE BROKEN
	 #@post = Post.new(post_params)
     #@post.user_id = @current_user.id		#sets the user_id FK
	 #@post.issue_id = @issue.id
	 #@post.issue_id = currentIssue
	 
	 @post.user_id = session[:user_id]
	 #@post.user_id = 1
     @post.save					#saves the @post 					
								#object to the posts table
	respond_to do |format|
		format.html { redirect_to @issue }
    end
end

def edit
	@issue = Issue.find(params[:issue_id])
    @post = @issue.posts.find(params[:id])
	#@post = Post.find(params[:id])
	#@issue = Issue.find params[:issue_id]
	#@post = @issue.posts.find(params[:id])
	#authorize! :update, @user
end

def update
	@issue = Issue.find(params[:issue_id])
    @post = @issue.posts.find(params[:id])

    if @post.update(post_params)
	  flash[:notice] = "Post updated successfully"
      redirect_to issue_path(@issue)
    else
      render 'edit'
    end
	#@post = Post.find(params[:id])
	#if @post.update_attributes(post_params)
	#	flash[:notice] = "User updated successfully"
	#	redirect_to(:action => "show", :id => @issue.id)
	#else
	#	render("edit")
	#end
end

def delete
	@issue = Issue.find(params[:issue_id])
    @post = @issue.posts.find(params[:id])
end
  
  def destroy
	@issue = Issue.find(params[:issue_id])
    @post = @issue.posts.find(params[:id])
	@post.destroy
	flash[:notice] = "Post destroyed successfully"
	redirect_to issue_path(@issue)
  end

 private
	def post_params
	#same as using “params[:post]”, except that it:
	# - raises an error if :post is not present
	# - allows listed attributes to be mass-assigned
		params.require(:post).permit(:id, :content, :user_id, :issue_id)
	end
	
	#def set_issue
	#	@issue = Issue.find(params[:id])
	#end

end
