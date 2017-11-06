class Company < ApplicationRecord
  has_many :jobs
  has_many :users
  has_many :articles

  def self.get_all_company
    sql = "SELECT * FROM companies"
    all_companies = self.find_by_sql(sql)  # 最後一行是回傳值
  end

end
