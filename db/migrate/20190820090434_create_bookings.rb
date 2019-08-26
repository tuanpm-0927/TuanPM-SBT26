# frozen_string_literal: true

class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.integer :user_id
      t.integer :tourdetail_id
      t.integer :informationbooktour_id
      t.integer :status

      t.timestamps
    end
  end
end
