class AddPictueToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :banner, :string
  end
end
