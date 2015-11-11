class DropIssuesTable < ActiveRecord::Migration
  def change
	drop_table :issues
  end
end
