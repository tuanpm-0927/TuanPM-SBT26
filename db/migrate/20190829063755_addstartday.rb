class Addstartday < ActiveRecord::Migration[5.2]
  def change
    add_column :tours, :start_days, :string
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
