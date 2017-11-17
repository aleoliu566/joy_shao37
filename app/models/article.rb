class Article < ApplicationRecord
	
  belongs_to :user
  belongs_to :company

    #UPDATE 
    def self.hr_update_article(a,title,content)
      t = DateTime.now
      query = <<-SQL
      UPDATE articles 
      SET title = "#{title}", content = "#{content}", updated_at="#{t}"
      WHERE id = "#{a}"
      SQL
      self.find_by_sql(query)
    end

    #DELETE
    def self.hr_delete_article(a)
      query = <<-SQL
      DELETE FROM articles
      WHERE id = "#{a}"
      SQL
      self.find_by_sql(query)
    end

    #CREATE
    def self.hr_create_article(cid,uid,title,content)
      t = DateTime.now
      query = <<-SQL
      INSERT INTO articles(company_id,user_id,title,content,created_at,updated_at)
      VALUES ("#{cid}","#{uid}","#{title}","#{content}","#{t}","#{t}")
      SQL
      self.find_by_sql(query)
    end

	#顯示
    def self.hr_get_all_article(c)
    # 把sql寫在這邊
      query = <<-SQL
      SELECT * FROM articles
      WHERE company_id = "#{c}"
      SQL
      all_articles = self.find_by_sql(query)  
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
