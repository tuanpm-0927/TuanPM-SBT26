# frozen_string_literal: true

class Addimagetocategory < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :image, :string
    # Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
