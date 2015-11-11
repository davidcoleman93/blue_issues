class AddDepartmentsTable < ActiveRecord::Migration
  def up
    create_table :departments do |t|
      t.string "dept_name", :null => false
	  t.integer "manager_id"
	  
	  t.timestamps
    end
  end
  
  def down
	drop_table :departments
  end
end
