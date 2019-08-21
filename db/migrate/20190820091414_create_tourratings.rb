# frozen_string_literal: true

class CreateTourratings < ActiveRecord::Migration[5.2]
  def change
    create_table :tourratings do |t|
      t.integer :tour_id
      t.integer :user_id
      t.string :rating_number

      t.timestamps
    end
  end
end
