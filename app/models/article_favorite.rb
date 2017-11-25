class ArticleFavorite < ApplicationRecord
	belongs_to :user
  	belongs_to :article

  	#READ USER FAV
     def self.get_all_fav(uid)
     # 把sql寫在這邊
     query = <<-SQL
     SELECT article_favorites.article_id AS articleId , articles.title AS articleTitle, companies.name AS companyName
     FROM article_favorites,users,articles,companies
     WHERE users.id = article_favorites.user_id AND articles.id = article_favorites.article_id AND article_favorites.user_id = "#{uid}" AND articles.company_id = companies.id AND companies.account_status = "open"
     ORDER BY companies.id
     SQL
     self.find_by_sql(query)
     end

     def self.new_article_fav(uid,aid)
     t = DateTime.now.strftime('%Y-%m-%d %H:%M:%S')
     query = <<-SQL
     INSERT INTO article_favorites(user_id,article_id,created_at,updated_at)
     VALUES ("#{uid}","#{aid}","#{t}","#{t}")
     SQL
     ActiveRecord::Base.connection.exec_query(query)
     end

     def self.delete_article_fav(uid,aid)
     t = DateTime.now.strftime('%Y-%m-%d %H:%M:%S')
     query = <<-SQL
     DELETE FROM article_favorites
     WHERE user_id = "#{uid}" AND  article_id = "#{aid}"
     SQL
     ActiveRecord::Base.connection.exec_query(query)
     end

end
