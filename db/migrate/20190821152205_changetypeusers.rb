# frozen_string_literal: true

class Changetypeusers < ActiveRecord::Migration[5.2]
  def change
    change_column :categories, :type_post, :string, limit: 10
    # Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
