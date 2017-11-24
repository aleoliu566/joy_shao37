class CreateCompanyFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :company_favorites do |t|
      t.integer :company_id
      t.integer :user_id
      t.timestamps
    end
  end
end
