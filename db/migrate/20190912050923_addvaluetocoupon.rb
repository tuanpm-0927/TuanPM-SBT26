class Addvaluetocoupon < ActiveRecord::Migration[5.2]
  def change
    add_column :coupons, :value, :integer, default: 0
  end
end
