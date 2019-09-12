class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.integer :user_id
      t.string :coupon
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
