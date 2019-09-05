class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :image_link
      t.integer :tour_id

      t.timestamps
    end
  end
end
