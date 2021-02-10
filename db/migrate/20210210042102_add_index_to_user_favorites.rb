class AddIndexToUserFavorites < ActiveRecord::Migration[5.2]
  def change
    add_index :user_favorites, [:user_id, :store_id], unique: true
  end
end
