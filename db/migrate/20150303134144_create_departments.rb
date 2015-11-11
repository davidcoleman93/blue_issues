class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
	  t.string "dept_name", :null => false
	  t.integer "manager_id"
	  
      t.timestamps
    end
  end
end
