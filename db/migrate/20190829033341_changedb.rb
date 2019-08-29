class Changedb < ActiveRecord::Migration[5.2]
  def change
    rename_table :commentposts, :comments
    rename_column :payments, :userbooktour_id, :booking_id
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
