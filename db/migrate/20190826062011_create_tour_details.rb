class CreateTourDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :tourdetails do |t|
      t.integer :tour_id
      t.date :day_start
      t.timestamps
    end
  end
end
