class Adddefaultstatusbooking < ActiveRecord::Migration[5.2]
  def change
    change_column :bookings, :status, :integer, default: 0
  end
end
