class CreateCheckout < ActiveRecord::Migration[6.0]
  def up
    create_table :checkouts do |t|
      t.integer "user_id", :null => false
      t.string "item_name", :limit => 50, :null => false
      t.string "checkout_reason", :limit => 100, :null => false
      t.timestamps
    end
  end
  
  def down
      drop_table :checkouts
  end
end
