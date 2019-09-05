class AddTotalBookingToTourdetail < ActiveRecord::Migration[5.2]
  def change
    add_column :tourdetails, :total_booking, :integer, default: 0
  end
end
