class AddAutoAssignOptionToUsers < ActiveRecord::Migration
  def change
	add_column "users", "auto-assign", :boolean, :default => false
  end
end
