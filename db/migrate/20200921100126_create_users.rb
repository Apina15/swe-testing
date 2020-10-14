class CreateUsers < ActiveRecord::Migration[6.0]
  def up
    create_table :users do |t|
      t.string "first_name", :limit => 25, :null => false
      t.string "last_name", :limit => 50, :null => false
      t.string "email", :default => '', :null => false
      t.string "password_digest", :null => false
      t.integer "permissions", :default => 2, :null => false
      t.integer "item_ids", :array => true, :default => []
      t.timestamps
    end
  end
  
  def down
      drop_table :users
  end
  
end
