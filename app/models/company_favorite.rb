class CompanyFavorite < ApplicationRecord
	belongs_to :user
  	belongs_to :company

  	 #READ USER FAV
     def self.get_all_fav(uid)
     # 把sql寫在這邊
     query = <<-SQL
     SELECT company_favorites.company_id AS companyId , companies.name AS companyName
     FROM company_favorites,users,companies
     WHERE users.id = company_favorites.user_id AND companies.id = company_favorites.company_id AND company_favorites.user_id = "#{uid}" 
     ORDER BY companies.id
     SQL
     self.find_by_sql(query)
     end

     def self.new_company_fav(uid,cid)
     t = DateTime.now.strftime('%Y-%m-%d %H:%M:%S')
     query = <<-SQL
     INSERT INTO company_favorites(user_id,company_id,created_at,updated_at)
     VALUES ("#{uid}","#{cid}","#{t}","#{t}")
     SQL
     ActiveRecord::Base.connection.exec_query(query)
     end

     def self.delete_company_fav(uid,cid)
     t = DateTime.now.strftime('%Y-%m-%d %H:%M:%S')
     query = <<-SQL
     DELETE FROM company_favorites
     WHERE user_id = "#{uid}" AND  company_id = "#{cid}"
     SQL
     ActiveRecord::Base.connection.exec_query(query)
     end
end
