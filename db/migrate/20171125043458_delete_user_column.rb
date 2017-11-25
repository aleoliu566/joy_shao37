class DeleteUserColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :nickname
    remove_column :users, :phone
    remove_column :users, :address
  end
end
