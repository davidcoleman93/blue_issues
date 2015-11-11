class AddAcceptedToIssues < ActiveRecord::Migration
  def change
	add_column "issues", "accepted", :boolean, :default => false
  end
end
