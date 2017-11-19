class Company < ApplicationRecord
  has_many :jobs
  has_many :users
  has_many :articles

  mount_uploader :logo, LogoUploader

  def ban

    account_status = self.account_status != "banned" ? "banned" : "open"
    # 若account_status="banned"，代表該公司被停權，禁止新增職缺

  	# query = <<-SQL
  	# UPDATE companies
   #  SET account_status="#{account_status}"
   #  WHERE name="#{self.name}"
  	# SQL

   #  self.find_by_sql(query)
  
   self.update_column("account_status", account_status)


  end


  #UPDATE 
  def self.hr_update_company(c,name,phone,email,address,about)
    t = DateTime.now
    query = <<-SQL
    UPDATE companies
    SET name = "#{name}", phone = "#{phone}", email = "#{email}",address = "#{address}",about = "#{about}",updated_at="#{t}"
    WHERE id = "#{c}"
    SQL
    self.find_by_sql(query)
  end


  def self.adminGetCompanyList

    query = <<-SQL
    SELECT C.id, C.name, C.views_count, C.account_status, COUNT(RJ.id) AS resume_count
    FROM (companies AS C LEFT JOIN jobs AS J ON C.id=J.company_id) LEFT JOIN resume_jobships AS RJ ON J.id=RJ.resume_id
    GROUP BY (C.id) 
    SQL

    return find_by_sql(query)
    
  end



end
