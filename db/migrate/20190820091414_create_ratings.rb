# frozen_string_literal: true

class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.integer :tour_id
      t.integer :user_id
      t.string :rating_number

      t.timestamps
    end
  end
end
