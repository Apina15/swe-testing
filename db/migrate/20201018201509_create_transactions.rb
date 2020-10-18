# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string 'user_id'
      t.string 'requestor_name'
      t.string 'requestor_email'
      t.string 'type_'
      t.string 'item_name'
      t.integer 'item_quantity'
      t.date 'remind_date'

      t.timestamps
    end
  end
end
