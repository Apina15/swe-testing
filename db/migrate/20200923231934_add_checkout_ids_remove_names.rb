class AddCheckoutIdsRemoveNames < ActiveRecord::Migration[6.0]
  def change
    add_column :checkouts, :item_id, :integer
    remove_column :checkouts, :item_name, :string
  end
  
  def down
      add_column :checkouts, :item_name, :string
      remove_column :checkouts, :item_id
  end

end
