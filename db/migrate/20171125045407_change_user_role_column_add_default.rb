class ChangeUserRoleColumnAddDefault < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :role, :boolean, :default => false
  end
end
