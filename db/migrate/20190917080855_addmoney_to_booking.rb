class AddmoneyToBooking < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :total_money, :integer, default: 0
  end
end
