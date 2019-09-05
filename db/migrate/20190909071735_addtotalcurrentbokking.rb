class Addtotalcurrentbokking < ActiveRecord::Migration[5.2]
  def change
    add_column :tourdetails, :total_current_booking, :integer, default: 0
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
