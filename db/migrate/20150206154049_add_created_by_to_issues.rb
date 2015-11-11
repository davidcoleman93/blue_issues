class AddCreatedByToIssues < ActiveRecord::Migration
  def up
	add_column "issues", "created_by", :integer
  end
  
  def down
	remove_column "issues", "created_by", :integer
  end
end
