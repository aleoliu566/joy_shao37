class Company < ApplicationRecord
  has_many :jobs
  has_many :users
  has_many :articles

  def ban

  	# query = <<-SQL
  	# UPDATE account_status="banned" FROM companies WHERE name="#{self.name}"
  	# SQL
  	# 若account_status="banned"，代表該公司被停權，禁止新增職缺
    
    # 判斷公司是否被停權
    if self.account_status != "banned"
    	self.update_column("account_status", "banned")
    else
      self.update_column("account_status", "open")
    end
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



end
