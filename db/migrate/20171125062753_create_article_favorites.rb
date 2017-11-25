class CreateArticleFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :article_favorites do |t|
      t.integer :article_id
      t.integer :user_id
      t.timestamps
    end
  end
end
