class Adddefaultstatustopayment < ActiveRecord::Migration[5.2]
  def change
    change_column :payments, :status, :integer, default: 0
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
