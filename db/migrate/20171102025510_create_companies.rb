class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :address
      t.text :about
      t.integer :scale
      t.integer :views_count, :default => 0
      t.string :account_status
      t.string :resume_password

      t.timestamps
    end
  end
end
