class DropPostLikes < ActiveRecord::Migration[6.0]
  def change
    if table_exists?(:post_likes)
      drop_table :post_likes
    else
      Rails.logger.info "Table 'post_likes' already dropped"
    end
  end
end
