class CreateStoreFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :store_favorites do |t|
      t.integer :follower_id, null: false
      t.integer :followed_id, null: false

      t.timestamps
    end
    add_index :store_favorites, :follower_id
    add_index :store_favorites, :followed_id
    add_index :store_favorites, [:follower_id, :followed_id], unique: true
  end
end
