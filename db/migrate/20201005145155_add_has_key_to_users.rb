class AddHasKeyToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :hasKey, :int, default: 0
  end
end
