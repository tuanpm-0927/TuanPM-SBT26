# frozen_string_literal: true

class Adddigesttouser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :password_confirmation, :string
    # Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
