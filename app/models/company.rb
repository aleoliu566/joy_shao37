class Company < ApplicationRecord
  has_many :jobs
  has_many :users
  has_many :articles
  has_many :company_favorites
  has_many :company_fans, :through => :company_favorites, :source => :user

  mount_uploader :logo, LogoUploader

  def self.execute
      query = <<-SQL
      SELECT * , COUNT(gender) AS count
      FROM ADMIN_VIEW
      GROUP BY name, gender   
      SQL
    self.find_by_sql(query)
  end

  def self.execute2(id)
     query = <<-SQL
      SELECT *
      FROM test
      WHERE com = "#{id}"
      SQL
    self.find_by_sql(query)
  end  

    # account_status = self.account_status != "banned" ? "banned" : "open"
    # 若account_status="banned"，代表該公司被停權，禁止新增職缺

  def ban(status)
    if status == 'banned'
    	query = <<-SQL
    	UPDATE companies
      SET account_status="open"
      WHERE name="#{self.name}"
    	SQL
    else
      query = <<-SQL
      UPDATE companies
      SET account_status="banned"
      WHERE name="#{self.name}"
      SQL
    end
    ActiveRecord::Base.connection.exec_query(query)
    return true
  end

  def self.search_company(search)
    query = <<-SQL
    SELECT *
    FROM companies
    WHERE name LIKE '%#{search}%'
    SQL
    self.find_by_sql(query)
  end

  def self.get_limit_company
    query = <<-SQL
    SELECT *
    FROM companies
    WHERE account_status = "open"
    ORDER BY views_count DESC
    LIMIT 3
    SQL
    self.find_by_sql(query)
  end

  def self.get_all_company
    query = <<-SQL
    SELECT *
    FROM companies
    WHERE account_status = "open"
    SQL
    self.find_by_sql(query)
  end

  # def self.hr_get_company(uid)
  #   query = <<-SQL
  #   SELECT *
  #   FROM companies
  #   WHERE companies.id = 4
  #   SQL
  #   self.find_by_sql(query)
  # end
  # def self.update_company_views(cid)
  #     t = DateTime.now.strftime('%Y-%m-%d %H:%M:%S')
  #     query = <<-SQL
  #     UPDATE companies,(SELECT views_count FROM companies WHERE id = "#{cid}") AS B
  #     SET companies.views_count = (B.views_count + 1), updated_at = "#{t}"
  #     WHERE id = "#{cid}"
  #     SQL
  # end 

  #UPDATE_hr
  def self.hr_update_company(c,name,phone,email,address,about,scale,logo)
    t = DateTime.now.strftime('%Y-%m-%d %H:%M:%S')
    query = <<-SQL
    UPDATE companies
    SET name = "#{name}", phone = "#{phone}", email = "#{email}",address = "#{address}",about = "#{about}",scale = "#{scale}",logo = "#{logo}",updated_at="#{t}"
    WHERE id = "#{c}"
    SQL
    h_u_company = ActiveRecord::Base.connection.exec_query(query)
  end

  #CREATE_admin
  def self.admin_create_company(name,phone,email,address,about,scale)
    t = DateTime.now.strftime('%Y-%m-%d %H:%M:%S')
    query = <<-SQL
    INSERT INTO companies(name,phone,email,address,about,scale,created_at,updated_at)
    VALUES ("#{name}","#{phone}","#{email}","#{address}","#{about}","#{scale}","#{t}","#{t}")
    SQL
    a_c_article = ActiveRecord::Base.connection.exec_query(query)
  end

  #UPDATE_admin
  def self.admin_update_company(c,name,phone,email,address,about)
    t = DateTime.now.strftime('%Y-%m-%d %H:%M:%S')
    query = <<-SQL
    UPDATE companies
    SET name = "#{name}", phone = "#{phone}", email = "#{email}",address = "#{address}",about = "#{about}",updated_at="#{t}"
    WHERE id = "#{c}"
    SQL
    a_u_company = ActiveRecord::Base.connection.exec_query(query)
  end

  #DELETE_admin
  def self.admin_delete_company(c)
    query = <<-SQL
    DELETE FROM companies
    WHERE id = "#{c}"
    SQL
    a_d_company = ActiveRecord::Base.connection.exec_query(query)
  end


  def self.adminGetCompanyList
    query = <<-SQL
    SELECT C.id, C.name, C.views_count, C.account_status, COUNT(CF.user_id) AS fav_count,
    (SELECT COUNT(RJ.resume_id) FROM resume_jobships AS RJ, jobs AS J WHERE RJ.job_id = J.id AND C.id = J.id) AS resume_count
    FROM companies AS C 
    LEFT JOIN company_favorites AS CF ON  CF.company_id = C.id 
    GROUP BY C.id
    SQL
    return find_by_sql(query)
  end

  def self.update_view_count(id)
    query = <<-SQL
    UPDATE companies
    SET views_count=(SELECT t from (select companies.views_count as t FROM companies WHERE id="#{id}") as sub_table)+1
    WHERE id="#{id}"
    SQL
    ActiveRecord::Base.connection.exec_query(query)
    return true
  end

end
