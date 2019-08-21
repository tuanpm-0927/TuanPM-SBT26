class RenameTypeCategory < ActiveRecord::Migration[5.2]
  def change
    rename_column :categories, :type, :type_post
  end
end
