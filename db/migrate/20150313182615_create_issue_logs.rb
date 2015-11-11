class CreateIssueLogs < ActiveRecord::Migration
  def change
    create_table :issue_logs do |t|
      t.text :content
      t.integer :user_id
      t.integer :issue_id

      t.timestamps
    end
  end
end
