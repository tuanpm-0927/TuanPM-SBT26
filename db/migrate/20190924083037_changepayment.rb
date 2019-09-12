class Changepayment < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :payment_code, :string
    add_column :payments, :payment_digest, :string
  end
end
