# frozen_string_literal: true

class CreateUserbooktours < ActiveRecord::Migration[5.2]
  def change
    create_table :userbooktours do |t|
      t.integer :user_id
      t.integer :tour_id
      t.integer :informationbooktour_id
      t.integer :status

      t.timestamps
    end
  end
end
