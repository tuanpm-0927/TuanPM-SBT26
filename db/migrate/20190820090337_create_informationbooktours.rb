# frozen_string_literal: false

class CreateInformationbooktours < ActiveRecord::Migration[5.2]
  def change
    create_table :informationbooktours do |t|
      t.string :fullname
      t.string :phonenumber
      t.string :address
      t.text :note

      t.timestamps
    end
  end
end
