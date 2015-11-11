class User < ActiveRecord::Base

has_many :issues, class_name: "Issue", foreign_key: "created_by"
has_many :issues, class_name: "Issue", foreign_key: "assigned_to"
has_one :department, class_name: "Department", foreign_key: "manager_id"
belongs_to :department, class_name: "Department", foreign_key: :department_id #do i need a many to many table
#belongs_to :department, class_name: "Department", foreign_key: :manager_id

has_many :posts, :dependent => :destroy
has_many :issue_logs, :dependent => :destroy

has_many :watchers, :dependent => :destroy


has_secure_password

EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

validates :first_name, :presence => true, :length => { :maximum => 25 }
validates :last_name, :presence => true, :length => { :maximum => 50}
validates :username, :length => {:within => 8..25}, :uniqueness => true
validates :email, :presence => true, :length => { :maximum => 100 }, :format => EMAIL_REGEX,:confirmation => true

	def self.firstname_search(query)
		where("first_name like ?", "%#{query}%")
	end

	def self.lastname_search(query)
		# where(:name, query) -> This would return an exact match of the query
		where("last_name like ?", "%#{query}%") 
	end

	def self.title_search(query)
		# where(:name, query) -> This would return an exact match of the query
		where("title like ?", "%#{query}%")
	end
	
	def self.username_search(query)
		# where(:name, query) -> This would return an exact match of the query
		where("username like ?", "%#{query}%")
	end

end
