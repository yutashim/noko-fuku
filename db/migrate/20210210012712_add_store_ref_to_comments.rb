class AddStoreRefToComments < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :store, foreign_key: true
  end
end
