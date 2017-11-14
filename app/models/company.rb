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
end
