# frozen_string_literal: true

class CreatePaymentbankings < ActiveRecord::Migration[5.2]
  def change
    create_table :paymentbankings do |t|
      t.integer :status
      t.integer :payment_id
      t.integer :banking_id

      t.timestamps
    end
  end
end
