# frozen_string_literal: true

class CreateLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :logs do |t|
      t.string 'user_id'
      t.string 'requestor_name'
      t.string 'requestor_email'
      t.string 'type_'
      t.string 'item_name'
      t.integer 'item_quantity'

      t.date 'check_in'

      t.timestamps
    end
  end
end
