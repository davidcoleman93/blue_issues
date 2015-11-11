class AddTimeToCompleteColumnToIssues < ActiveRecord::Migration
  def change
	add_column "issues", "time_to_complete", :integer
  end
end
