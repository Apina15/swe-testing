class CreateItems < ActiveRecord::Migration[6.0]
  def up
    create_table :items do |t|
      t.string "name"
      t.string "description"
      t.integer "total_stock"
      t.integer "avail_stock"
      t.string "location"

      t.timestamps
    end
  end

  def down
    drop_table :items
  end
end
