class Addrequestbooking < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :request, :boolean, default: false
  end
end
