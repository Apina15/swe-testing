class AddEventToTransactionsAndLogs < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :event, :string, :limit => 100, :null => false
    add_column :logs, :event, :string, :limit => 100, :null => false
  end
end
