class Addvaluedefaulttotour < ActiveRecord::Migration[5.2]
  def change
    change_column :tours, :total_member_current, :integer, :default => 0
    change_column :tours, :rating_average, :integer, :default => 0
    change_column :tours, :total_day, :integer, :default => 0
    change_column :tours, :discount, :integer, :default => 0
  end
end
