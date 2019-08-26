# frozen_string_literal: true

class CreateBankings < ActiveRecord::Migration[5.2]
  def change
    create_table :bankings do |t|
      t.string :account_number
      t.string :username
      t.string :password
      t.decimal :money
      t.string :fullname

      t.timestamps
    end
  end
end
