class AddArticleStatusToArticles < ActiveRecord::Migration[5.1]
  def change
  	add_column :articles, :article_status, :string, default: 'auditing'
  end
end
