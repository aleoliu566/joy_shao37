class ChangeUserGenderToBoolean < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :gender, :boolean
  end
end
