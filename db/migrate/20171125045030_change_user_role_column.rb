class ChangeUserRoleColumn < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :role, :boolean
  end
end
