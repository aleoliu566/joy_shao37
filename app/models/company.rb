class Company < ApplicationRecord
  has_many :jobs
  has_many :users
  has_many :articles

  def self.get_all_company
    # 把sql寫在這邊
    sql = "SELECT * FROM companies"

    all_companies = self.find_by_sql(sql)  # 最後一行是回傳值
  end

  def self.get_all_company_v2
    # 把sql寫在這邊
    query = <<-SQL
    SELECT * FROM companies
    SQL

    all_companies = self.find_by_sql(query)  # 最後一行是回傳值
  end

end
