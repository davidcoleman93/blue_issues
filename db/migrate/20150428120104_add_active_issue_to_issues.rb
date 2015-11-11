class AddActiveIssueToIssues < ActiveRecord::Migration
  def change
	add_column "issues", "active_issue", :boolean, :default => false
  end
end
