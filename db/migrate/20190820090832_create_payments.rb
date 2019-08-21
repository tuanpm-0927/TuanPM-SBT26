# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.integer :userbooktour_id
      t.integer :status
      t.integer :method_payment
      t.decimal :amount

      t.timestamps
    end
  end
end
