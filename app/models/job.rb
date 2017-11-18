class Job < ApplicationRecord
  belongs_to :company
  # 關聯
  has_many :resume_jobships
  has_many :resumes, :through => :resume_jobships 
  #資料驗證
  validates_presence_of :name, :published_on, :content, :hour_salary_ceiling, :hour_salary_floor, :year_salary_floor, :year_salary_ceiling

    #CREATE JOB
    def self.hr_create_job(cid,n,p,c,hc,hf,yc,yf)
      t = DateTime.now
      query = <<-SQL
      INSERT INTO jobs(company_id,name,published_on,content,hour_salary_ceiling,hour_salary_floor,year_salary_ceiling,year_salary_floor,created_at,updated_at)
      VALUES ("#{cid}","#{n}","#{p}","#{c}","#{hc}","#{hf}","#{yc}","#{yf}","#{t}" ,"#{t}")
      SQL
      self.find_by_sql(query)
    end

  	# #READ JOB 
   #  def self.hr_get_all_job(c)
   #   # 把sql寫在這邊
   #   query = <<-SQL
   #   SELECT jobs.id, jobs.name, jobs.published_on, jobs.content, jobs.year_salary_ceiling, jobs.year_salary_floor, jobs.hour_salary_ceiling,jobs.hour_salary_floor, users.email
   #   FROM jobs
   #   JOIN users, resumes
   #   ON resumes.user_id = users.id 
   #   WHERE jobs.company_id = "#{c}"
   #   SQL
   #   all_jobs = self.find_by_sql(query)  # 最後一行是回傳值
   #  end

    #READ JOB 
    def self.hr_get_all_job(c)
     # 把sql寫在這邊
     query = <<-SQL
     SELECT *
     FROM jobs
     WHERE jobs.company_id = "#{c}"
     SQL
     all_jobs = self.find_by_sql(query)  # 最後一行是回傳值
    end

    #UPDATE
    def self.hr_update_job(j,n,p,c,hc,hf,yc,yf)
      t = DateTime.now
      query = <<-SQL
      UPDATE jobs 
      SET name = "#{n}", published_on = "#{p}", content = "#{c}", hour_salary_ceiling = "#{hc}", hour_salary_floor = "#{hf}", updated_at = "#{t}", year_salary_ceiling  = "#{yc}", year_salary_floor = "#{yf}"
      WHERE id = "#{j}"
      SQL
      self.find_by_sql(query)
    end

 	  #DELETE
    def self.hr_delete_job(j)
      query = <<-SQL
      DELETE FROM jobs WHERE id = "#{j}"
      SQL
      self.find_by_sql(query)
    end

end
