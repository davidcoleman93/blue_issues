class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
       user ||= User.new # guest user (not logged in)
       if user.admin?
			can :manage, :all 
			can :manage, Post
			can :manage, Department
       else
			#can :read, :all
       end
	   
	   if user.manage?
			can :manage, Issue do |issue|
				issue && issue.assignee.department_id == user.department_id
			end
			can :manage, Watcher
			can :read, :all
			if user.admin?
				can :manage, Department
			else
				cannot :read, Department
			end
			can :destroy, Post do |post|
				post && post.user_id == user.id
			end
	   end
	   
	   if user.normal?
			can :create, Issue
			can :update, Issue do |issue|
				issue && issue.assignee == user
			end
		
			#can :new, Post
			can :create, Post
			can :update, Post do |post|
				post && post.user_id == user.id
			end
			can :show, User do |thisuser|
				thisuser && thisuser == user
			end
			#cant :index, User 
		
			can :myissues, Issue
			can :mytasks, Issue
			can :mypastissues, Issue
			can :mypasttasks, Issue
			can :read, Issue #Later, make it so they can only read issues from their department.
						#OR maybe they can read (or maybe update) if they created the issue or are a watcher.
	   end
	   
	   if user.basic?
			can :create, Issue
			can :myissues, Issue
			#cannot :mytasks, Issue
		
			can :show, User do |thisuser|
				thisuser && thisuser == user
			end
	   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
