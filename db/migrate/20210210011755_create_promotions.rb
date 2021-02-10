class CreatePromotions < ActiveRecord::Migration[5.2]
  def change
    create_table :promotions do |t|
      t.references :store, foreign_key: true
      t.string :title
      t.text :content, null: false

      t.timestamps
    end
  end
end
