class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.integer :view_count, :default => 0

      t.integer :company_id, index: true
      t.integer :user_id, index: true

      t.timestamps
    end
  end
end
