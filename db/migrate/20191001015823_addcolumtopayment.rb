class Addcolumtopayment < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :expires_at, :datetime
    add_column :payments, :purchased_at, :datetime
    add_column :payments, :quantity, :integer
  end
end
