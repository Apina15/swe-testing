class MerchUpdate < ActiveRecord::Migration[6.0]
  def up
      add_column(:items, :merch, :string, :limit => 10)
  end
  
  def down
       remove_column(:items, :merch)
  end
end
