# frozen_string_literal: true

class CreateTours < ActiveRecord::Migration[5.2]
  def change
    create_table :tours do |t|
      t.string :title
      t.text :content
      t.date :day_start
      t.string :address_source
      t.string :address_distance
      t.decimal :price
      t.decimal :discount
      t.decimal :price_discount
      t.integer :total_day
      t.integer :total_member_max
      t.integer :total_member_current
      t.decimal :rating_average
      t.string :images
      t.integer :category_id

      t.timestamps
    end
  end
end
