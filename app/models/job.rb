class Job < ApplicationRecord
  belongs_to :company
  # 關聯
  has_many :resume_jobships
  has_many :resumes, :through => :resume_jobships 
  has_many :tag_jobships
  has_many :tags, :through => :tag_jobships
  #資料驗證
  validates_presence_of :name, :published_on, :content, :hour_salary_ceiling, :hour_salary_floor, :year_salary_floor, :year_salary_ceiling

    #CREATE JOB
    def self.hr_create_job(cid,n,p,c,hc,hf,yc,yf)
      t = DateTime.now
      query = <<-SQL
      INSERT INTO jobs(company_id,name,published_on,content,hour_salary_ceiling,hour_salary_floor,year_salary_ceiling,year_salary_floor,created_at,updated_at,status)
      VALUES ("#{cid}","#{n}","#{p}","#{c}","#{hc}","#{hf}","#{yc}","#{yf}","#{t}" ,"#{t}","open")
      SQL
      self.find_by_sql(query)
    end

  	#READ COMPANY'S JOB (取得Job name, salary, tag, published_date)
    def self.hr_get_all_job(c)
     # 把sql寫在這邊
     query = <<-SQL
     SELECT jobs.*, GROUP_CONCAT (tags.name) AS tag
     FROM tags,tag_jobships,jobs
     WHERE tags.id = tag_jobships.tag_id AND jobs.id = tag_jobships.job_id AND company_id = '#{c}' 
     GROUP BY jobs.id
     SQL
     all_jobs = self.find_by_sql(query)  # 最後一行是回傳值
    end

    #READ ALL JOBS (各公司的開放職缺)
    def self.get_all_job
     # 把sql寫在這邊
     query = <<-SQL
     SELECT jobs.*, GROUP_CONCAT (tags.name) AS tag
     FROM tags,tag_jobships,jobs
     WHERE tags.id = tag_jobships.tag_id AND jobs.id = tag_jobships.job_id AND status = "open"
     GROUP BY jobs.id
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

    #Close_Open_Job
    def self.close_open_job(jobid,close)
      if close == 'close'
        query = <<-SQL
        UPDATE jobs
        SET status = 'open'   
        WHERE id = "#{jobid}"
        SQL
      else
        query = <<-SQL
        UPDATE jobs
        SET status = 'close'   
        WHERE id = "#{jobid}"
        SQL
      end
        self.find_by_sql(query)
    end
end