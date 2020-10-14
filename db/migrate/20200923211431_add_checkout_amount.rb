class AddCheckoutAmount < ActiveRecord::Migration[6.0]
  def up
    add_column :checkouts, :amount, :integer
  end
  def down
      remove_column :checkouts, :amount, :integer
  end
end
