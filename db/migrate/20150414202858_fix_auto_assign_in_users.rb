class FixAutoAssignInUsers < ActiveRecord::Migration
  def change
	remove_column "users", "auto-assign"
	add_column "users", "auto_assign", :boolean, :default => false
  end
end
