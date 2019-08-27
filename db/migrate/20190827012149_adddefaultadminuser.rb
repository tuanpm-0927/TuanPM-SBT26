class Adddefaultadminuser < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :admin, :integer, :default => 1
    #Ex:- :default =>''
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
