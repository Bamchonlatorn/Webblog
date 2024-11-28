class RenamePostLikesToLikes < ActiveRecord::Migration[6.0]
  def change
    rename_table :post_likes, :likes
  end
end
