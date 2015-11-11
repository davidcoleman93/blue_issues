class Department < ActiveRecord::Base
#belongs_to :user, class_name: "User", foreign_key: :manager_id
belongs_to :manager, class_name: "User", foreign_key: :manager_id
#has_one :manager, class_name: "User", foreign_key: "manager_id" #do I need a many to many table
has_many :users, class_name: "User", foreign_key: "department_id"

end
