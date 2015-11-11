class AddColumnAssignedToToIssues < ActiveRecord::Migration
  def up
	add_column "issues", "assigned_to", :integer
  end
  
  def down
	remove_column "issues", "assigned_to", :integer
  end
end
