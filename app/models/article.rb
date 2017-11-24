class Article < ApplicationRecord
	
  belongs_to :user
  belongs_to :company

  mount_uploader :banner, BannerUploader

    #UPDATE_hr
    def self.hr_update_article(a,title,content)
      t = DateTime.now.strftime('%Y-%m-%d %H:%M:%S')
      query = <<-SQL
      UPDATE articles 
      SET title = "#{title}", content = "#{content}", updated_at="#{t}"
      WHERE id = "#{a}"
      SQL
      h_u_article = ActiveRecord::Base.connection.exec_query(query)
    end

    #DELETE
    def self.hr_delete_article(a)
      query = <<-SQL
      DELETE FROM articles
      WHERE id = "#{a}"
      SQL
      h_d_article = ActiveRecord::Base.connection.exec_query(query)
    end

    #CREATE
    def self.hr_create_article(cid,uid,title,content)
      t = DateTime.now.strftime('%Y-%m-%d %H:%M:%S')
      query = <<-SQL
      INSERT INTO articles(company_id,user_id,title,content,created_at,updated_at)
      VALUES ("#{cid}","#{uid}","#{title}","#{content}","#{t}","#{t}")
      SQL
      h_c_article = ActiveRecord::Base.connection.exec_query(query)
    end

	  # #顯示
   #  def self.hr_get_all_article(c)
   #  # 把sql寫在這邊
   #    query = <<-SQL
   #    SELECT articles.id, articles.title, articles.content, users.email, companies.name, articles.view_count 
   #    FROM articles
   #    JOIN users, companies
   #    ON articles.user_id = users.id AND articles.company_id = companies.id
   #    WHERE articles.company_id = "#{c}"
   #    SQL
   #    h_get_article = ActiveRecord::Base.connection.exec_query(query)
   #  end

    #顯示_hr
    def self.hr_get_all_article(c)
    # 把sql寫在這邊
      query = <<-SQL
      SELECT articles.id, articles.title, articles.content, users.email, companies.name, articles.view_count, articles.created_at 
      FROM articles,users, companies
      WHERE articles.user_id = users.id AND articles.company_id = companies.id AND articles.company_id = "#{c}"
      GROUP BY articles.id
      SQL
      all_artilces = self.find_by_sql(query)  
    end

    #顯示_admin
    def self.admin_get_all_article(c)
    # 把sql寫在這邊
      query = <<-SQL
      SELECT articles.id, articles.title, articles.content, users.email, companies.name, articles.view_count 
      FROM articles,users, companies
      WHERE articles.user_id = users.id AND articles.company_id = companies.id AND articles.company_id = "#{c}"
      GROUP BY articles.id
      SQL
      all_artilces = self.find_by_sql(query)  
    end

    #UPDATE_admin
    def self.admin_update_article(a,title,content)
      t = DateTime.now.strftime('%Y-%m-%d %H:%M:%S')
      query = <<-SQL
      UPDATE articles 
      SET title = "#{title}", content = "#{content}", updated_at="#{t}"
      WHERE id = "#{a}"
      SQL
      a_u_article = ActiveRecord::Base.connection.exec_query(query)
    end

    def audit(article_status)

      # query = <<-SQL
      # UPDATE articles
      # SET article_status="#{article_status}"
      # WHERE title="#{self.title}"
      # SQL

      #self.find_by_sql(query)
      self.update_column("article_status", article_status)



    end


end
