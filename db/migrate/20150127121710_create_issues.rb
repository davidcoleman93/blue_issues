class CreateIssues < ActiveRecord::Migration
  def up
    create_table :issues do |t|
      t.string "title", :null => false
      t.string "priority", :null => false
      t.string "type"
      t.string "summary"
      t.string "status", :null => false

      t.timestamps
    end
  end
  
  def down
	drop_table :issues
  end
end
