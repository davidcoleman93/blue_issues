class AddRolesToUsers < ActiveRecord::Migration
  def change

	add_column "users", "admin", :boolean, :default => false
	add_column "users", "manage", :boolean, :default => false
	add_column "users", "normal", :boolean, :default => true
  end
end
