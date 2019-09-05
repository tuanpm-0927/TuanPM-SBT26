class Addactive < ActiveRecord::Migration[5.2]
  def change
    add_column :slides, :active, :boolean
  end
end
