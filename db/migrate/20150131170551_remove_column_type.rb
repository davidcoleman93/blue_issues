class RemoveColumnType < ActiveRecord::Migration
  def up
	remove_column :issues, :type
  end
  
  def down
	remove_column :issues, :type, :string
  end
end
