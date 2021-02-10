class ChangeStoresColumns < ActiveRecord::Migration[5.2]
  def change
    change_column_null :stores, :name, false
    change_column_null :stores, :email, false
  end
end
