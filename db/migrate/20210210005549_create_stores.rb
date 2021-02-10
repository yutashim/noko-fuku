class CreateStores < ActiveRecord::Migration[5.2]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :icon
      t.text :introduction
      t.integer :postcode
      t.string :prefecture
      t.string :city
      t.string :street_address

      t.timestamps
    end
    add_index :stores, :email, unique: true
  end
end
