class AddBasicRoleToUsers < ActiveRecord::Migration
  def change
	add_column "users", "basic", :boolean, :default => true
  end
end
