class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
	  t.string "first_name", :limit => 25
	  t.string "last_name", :limit => 45
	  t.string "title"
	  t.string "username", :limit => 25, :null => false
	  t.string "email", :null => false
	  t.date "DOB"
	  
	  
      t.timestamps
    end
  end
  
  def down
	drop_table :users
  end
end
