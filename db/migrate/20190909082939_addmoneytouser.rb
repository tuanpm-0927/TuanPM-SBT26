class Addmoneytouser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :money, :integer, default: 0
  end
end
