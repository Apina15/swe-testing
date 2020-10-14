class ChangeUserPermDefault < ActiveRecord::Migration[6.0]
  def up
    change_column_default :users, :permissions, from: 2, to: 0
  end
  
  def down
      change_column_default :users, :permissions, from: 0, to: 2
  end
end
