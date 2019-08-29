# frozen_string_literal: true

class CreateCommentposts < ActiveRecord::Migration[5.2]
  def change
    create_table :commentposts do |t|
      t.integer :user_id
      t.integer :post_id
      t.string :content

      t.timestamps
    end
  end
end
