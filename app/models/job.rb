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
     SELECT * FROM jobs WHERE company_id = "#{c}"
     SQL
     all_jobs = self.find_by_sql(query)  # 最後一行是回傳值
    end

 	  #DELETE
    def self.delete_job(j)
      query = <<-SQL
      DELETE FROM jobs WHERE id = "#{j}"
      SQL
      self.find_by_sql(query)
    end

    #CREATE
    def self.create_job(cid,n,p,c,hc,hf)
      t = DateTime.now
      query = <<-SQL
      INSERT INTO jobs(company_id,name,published_on,content,hour_salary_ceiling,hour_salary_floor,created_at,updated_at)
      VALUES ("#{cid}","#{n}","#{p}","#{c}","#{hc}","#{hf}","#{t}","#{t}")
      SQL
      self.find_by_sql(query)
    end


    #UPDATE
    def self.update_job(j,n,p,c,hc,hf)
      t = DateTime.now
      query = <<-SQL
      UPDATE jobs 
      SET name = "#{n}", published_on = "#{p}", content = "#{c}", hour_salary_ceiling = "#{hc}", hour_salary_floor = "#{hf}", updated_at = "#{t}"
      WHERE id = "#{j}"
      SQL
      self.find_by_sql(query)
    end


end
