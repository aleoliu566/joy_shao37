class Job < ApplicationRecord
  belongs_to :company
  #資料驗證
  validates_presence_of :name, :published_on, :content, :hour_salary_ceiling, :hour_salary_floor
  
  # 關聯
  has_many :resume_jobships
  has_many :resumes, :through => :resume_jobships


  	#READ(Select)
    def self.get_all_job(c)
     # 把sql寫在這邊
     query = <<-SQL
     SELECT * FROM jobs WHERE company_id = '#{c}'
     SQL
     all_jobs = self.find_by_sql(query)  # 最後一行是回傳值
    end

 	  #DELETE
    def self.delete_job(j)
      query = <<-SQL
      DELETE FROM jobs WHERE id = '#{j}'
      SQL
      self.find_by_sql(query)
    end

    #CREATE


    #UPDATE
    

end
