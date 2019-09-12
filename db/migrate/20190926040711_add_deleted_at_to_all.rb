class AddDeletedAtToAll < ActiveRecord::Migration[5.2]
  def change
    add_column :tourdetails, :deleted_at, :datetime
    add_index :tourdetails, :deleted_at
    add_column :ratings, :deleted_at, :datetime
    add_index :ratings, :deleted_at
    add_column :posts, :deleted_at, :datetime
    add_index :posts, :deleted_at
    add_column :payments, :deleted_at, :datetime
    add_index :payments, :deleted_at
    add_column :likes, :deleted_at, :datetime
    add_index :likes, :deleted_at
    add_column :informationbooktours, :deleted_at, :datetime
    add_index :informationbooktours, :deleted_at
    add_column :comments, :deleted_at, :datetime
    add_index :comments, :deleted_at
    add_column :bookings, :deleted_at, :datetime
    add_index :bookings, :deleted_at
  end
end
