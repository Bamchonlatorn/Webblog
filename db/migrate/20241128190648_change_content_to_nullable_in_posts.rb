class ChangeContentToNullableInPosts < ActiveRecord::Migration[6.0]
  def change
    change_column_null :posts, :content, true
  end
end
