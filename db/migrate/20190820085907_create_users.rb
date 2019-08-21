# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :fullname
      t.string :email
      t.date :birthday
      t.string :password
      t.string :phonenumber
      t.string :address
      t.string :remember_digest
      t.boolean :admin

      t.timestamps
    end
  end
end
