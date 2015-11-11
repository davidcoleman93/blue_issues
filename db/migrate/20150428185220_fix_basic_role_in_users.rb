class FixBasicRoleInUsers < ActiveRecord::Migration
  def change
    remove_column "users", "basic"
	add_column "users", "basic", :boolean, :default => false
  end
end
