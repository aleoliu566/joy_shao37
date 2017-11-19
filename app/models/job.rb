class Job < ApplicationRecord
  belongs_to :company
  # 關聯
  has_many :resume_jobships
  has_many :resumes, :through => :resume_jobships 
  #資料驗證
  validates_presence_of :name, :published_on, :content, :salary

    #CREATE JOB
    def self.hr_create_job(cid,n,p,c,s)
      t = DateTime.now
      query = <<-SQL
      INSERT INTO jobs(company_id,name,published_on,content,salary,created_at,updated_at)
      VALUES ("#{cid}","#{n}","#{p}","#{c}","#{s}","#{t}" ,"#{t}")
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
    def self.hr_update_job(j,n,p,c,s)
      t = DateTime.now
      query = <<-SQL
      UPDATE jobs 
      SET name = "#{n}", published_on = "#{p}", content = "#{c}", salary = "#{s}", updated_at = "#{t}"
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

    def self.getJobInfos
        
        query = <<-SQL
        SELECT J.id, J.name, J.content, J.views_count, C.name AS companyName
        FROM jobs AS J JOIN companies AS C ON J.company_id=C.id
        SQL
        
        return find_by_sql(query)

    end


    def self.getJobResumes
        
        query = <<-SQL
        SELECT J.id AS jId, U.name, R.attachment
        FROM (jobs AS J JOIN resume_jobships AS RJ ON J.id=RJ.job_id) JOIN resumes AS R ON RJ.resume_id=R.id JOIN users AS U ON R.user_id=U.id 
        SQL
        
        rsArr = find_by_sql(query)

        rsHash = {}
        for resume in rsArr do

          jId = resume.jId.to_s.to_sym

          if rsHash[jId] == nil
            rsHash[jId] = [resume]
          else
            rsHash[jId] << resume
          end

        end

        return rsHash

    end

end