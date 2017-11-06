class Company < ApplicationRecord
  has_many :jobs
  has_many :users
  has_many :articles

  def self.get_all_company_v2
    query = <<-SQL
    SELECT * FROM companies
    SQL

    all_companies = self.find_by_sql(query) # 最後一行是回傳值
  end

end
