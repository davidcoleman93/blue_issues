class Issue < ActiveRecord::Base
#belongs_to :user, class_name: "User"
#validates :assigned_to, :presence => true
#validates :created_by, :presence => true
#validates :user, :presence => true
#belongs_to :assigned_to, class_name: "User"
#belongs_to :created_by, class_name: "User"
belongs_to :assignee, class_name: "User", foreign_key: :assigned_to
belongs_to :creator, class_name: "User", foreign_key: :created_by
has_many :posts, :dependent => :destroy
has_many :watchers, :dependent => :destroy
has_many :issue_logs, :dependent => :destroy
validates :assignee, :presence => true
validates :created_by, :presence => true
	def self.search(query)
		where("title like ?", "%#{query}%")
	end

	def self.priority_search(query)
		# where(:name, query) -> This would return an exact match of the query
		where("priority like ?", "%#{query}%") 
	end

	def self.status_search(query)
		# where(:name, query) -> This would return an exact match of the query
		where("status like ?", "%#{query}%")
	end
	
	def self.assignee_search(query)
		# where(:name, query) -> This would return an exact match of the query
		where("assigned_to like ?", "%#{query}%")
	end

	def assigned_username
		assignee.try(:username)
	end
	
	def assigned_username=(username)
		self.assignee = User.find_by username: username if username.present?
		#self.assignee = User.find_by_username(username) if username.present?
		#self.assignee = User.where(:assigned_username => username) if username.present?
	end
	
	def self.current=(i)
		@current_issue = i
	end
	
	def self.current
		@current_issue
	end

end
