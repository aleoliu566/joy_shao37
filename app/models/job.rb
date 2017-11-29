class Job < ApplicationRecord
  belongs_to :company
  # 關聯
  has_many :resume_jobships
  has_many :resumes, :through => :resume_jobships 
  has_many :tag_jobships
  has_many :tags, :through => :tag_jobships
  has_many :job_favorites
  has_many :fans, :through => :job_favorites, :source => :user
  #資料驗證
  validates_presence_of :name, :published_on, :content, :salary

    #CREATE JOB
    def self.hr_create_job(cid,n,p,c,s,tagid)    
      t = DateTime.now.strftime('%Y-%m-%d %H:%M:%S')
      query = <<-SQL
      INSERT INTO jobs(company_id,name,published_on,content,salary,created_at,updated_at,status)
      VALUES ("#{cid}","#{n}","#{p}","#{c}","#{s}","#{t}" ,"#{t}","open")
      SQL
      ActiveRecord::Base.connection.exec_query(query)
   

      query2 = <<-SQL
      SELECT jobs.id
      FROM jobs
      WHERE company_id = "#{cid}" AND name = "#{n}"
      SQL
      job = ActiveRecord::Base.connection.exec_query(query2).rows.to_param

      noEmptyTags = tagid.reject { |tagid| tagid.empty? }
      noEmptyTags.each do |tagid|
      query3= <<-SQL
      INSERT INTO tag_jobships(tag_id,job_id,created_at,updated_at)
      VALUES ("#{tagid}","#{job}","#{t}","#{t}")
      SQL
      ActiveRecord::Base.connection.exec_query(query3)
      end

    end


  	#READ COMPANY'S JOB (取得Job name, salary, tag, published_date)
    #http://ponshanecode.blogspot.tw/2014/08/mysql.html M:N inner join
    def self.hr_get_all_job(c)
     # 把sql寫在這邊
     query = <<-SQL
     SELECT jobs.*, COUNT(job_favorites.user_id) AS fav_count
     ,(SELECT COUNT(resume_jobships.resume_id) FROM resume_jobships WHERE resume_jobships.job_id = jobs.id) AS res_count
     FROM jobs
     LEFT JOIN job_favorites ON  job_favorites.job_id = jobs.id 
     WHERE company_id = '#{c}' 
     GROUP BY jobs.id
     SQL
     all_jobs = self.find_by_sql(query)  # 最後一行是回傳值
    end

    #READ ALL JOBS (各公司的開放職缺)
    def self.get_all_job
     t = DateTime.now.strftime('%Y-%m-%d')
     # 把sql寫在這邊
     query = <<-SQL
     SELECT jobs.*, GROUP_CONCAT(tags.name) AS tag
     FROM tags,tag_jobships,jobs,companies
     WHERE tags.id = tag_jobships.tag_id AND jobs.id = tag_jobships.job_id AND companies.id = jobs.company_id AND companies.account_status = "open" AND status = "open" AND published_on <= "#{t}"
     GROUP BY jobs.id
     SQL
     all_jobs = self.find_by_sql(query)  # 最後一行是回傳值
    end

     def self.get_limit_job
     t = DateTime.now.strftime('%Y-%m-%d')
     # 把sql寫在這邊
     query = <<-SQL
     SELECT jobs.*, GROUP_CONCAT(tags.name) AS tag
     FROM tags,tag_jobships,jobs,companies
     WHERE tags.id = tag_jobships.tag_id AND jobs.id = tag_jobships.job_id AND companies.id = jobs.company_id AND companies.account_status = "open" AND status = "open" AND published_on <= "#{t}"
     GROUP BY jobs.id
     ORDER BY jobs.views_count DESC
     LIMIT 3
     SQL
     limit_jobs = self.find_by_sql(query)  # 最後一行是回傳值
    end

     def self.get_job(c)
     # 把sql寫在這邊
     query = <<-SQL
     SELECT jobs.*, GROUP_CONCAT(tags.name) AS tag
     FROM tags,tag_jobships,jobs
     WHERE tags.id = tag_jobships.tag_id AND jobs.id = tag_jobships.job_id AND company_id = '#{c}' AND status = "open"
     GROUP BY jobs.id
     SQL
     self.find_by_sql(query)  # 最後一行是回傳值
     end


     def self.get_a_job(c,jid)
     # 把sql寫在這邊
     query = <<-SQL
     SELECT jobs.*, GROUP_CONCAT(tags.name) AS tag
     FROM tags,tag_jobships,jobs
     WHERE tags.id = tag_jobships.tag_id AND jobs.id = tag_jobships.job_id AND company_id = '#{c}' AND status = "open" AND jobs.id NOT IN 
     (SELECT id FROM jobs WHERE id = "#{jid}")
     GROUP BY jobs.id 
     SQL
     self.find_by_sql(query)  # 最後一行是回傳值
     end

    #查看職缺詳細內容
    def self.get_detail_job(jid)
    query = <<-SQL
    SELECT jobs.* 
    FROM jobs 
    WHERE jobs.id = "#{jid}"
    SQL
    self.find_by_sql(query)  # 最後一行是回傳值
    end

    # def self.update_job_views(jid)
    #   t = DateTime.now.strftime('%Y-%m-%d %H:%M:%S')
    #   query = <<-SQL
    #   UPDATE jobs,(SELECT views_count FROM jobs WHERE id = "#{jid}") AS B
    #   SET jobs.views_count = (B.views_count + 1), updated_at = "#{t}"
    #   WHERE id = "#{jid}"
    #   SQL
    #   ActiveRecord::Base.connection.exec_query(query)  # 最後一行是回傳值
    # end


    def self.search_job(search)
      query = <<-SQL
      SELECT jobs.*,GROUP_CONCAT(tags.name) AS tag
      FROM tags,tag_jobships,jobs,companies
      WHERE jobs.name LIKE '%#{search}%' AND tags.id = tag_jobships.tag_id AND jobs.id = tag_jobships.job_id AND companies.id = jobs.company_id AND companies.account_status = "open" AND status = "open"
      GROUP BY jobs.id
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
  
    #UPDATE
    def self.hr_update_job(j,n,p,c,s,tagid)
      t = DateTime.now.strftime('%Y-%m-%d %H:%M:%S')
      query = <<-SQL
      
      UPDATE jobs
      SET name = "#{n}", published_on = "#{p}", content = "#{c}", salary = "#{s}", updated_at = "#{t}"
      WHERE id = "#{j}"
      SQL
      ActiveRecord::Base.connection.exec_query(query)

      query2 = <<-SQL
      DELETE FROM tag_jobships
      WHERE job_id = "#{j}"
      SQL
      ActiveRecord::Base.connection.exec_query(query2)

      #產生的Arr => ["",2,3] 只勾第二和第三個 
      #將empty string刪除
      noEmptyTags = tagid.reject { |tagid| tagid.empty? }
      #取每個array的值新增TagJobship table的資料
      noEmptyTags.each do |tagid|
      query3 = <<-SQL
      INSERT INTO tag_jobships(tag_id,job_id,created_at,updated_at)
      VALUES ("#{tagid}","#{j}","#{t}","#{t}")
      SQL
      ActiveRecord::Base.connection.exec_query(query3)
      end

    end

 	  #DELETE
    def self.hr_delete_job(j)
      query = <<-SQL
      DELETE FROM jobs WHERE id = "#{j}"
      SQL
      h_d_job = ActiveRecord::Base.connection.exec_query(query)
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
      ActiveRecord::Base.connection.exec_query(query)
        # self.find_by_sql(query)
    end

    def self.getJobInfos
        
        query = <<-SQL
        SELECT J.id, J.name, J.content, J.views_count, C.name AS companyName, COUNT(JF.user_id) AS fav_count
        FROM jobs AS J 
        JOIN companies AS C ON J.company_id=C.id
        LEFT JOIN job_favorites AS JF ON JF.job_id = J.id 
        WHERE C.account_status = "open"
        GROUP BY J.id
        ORDER BY C.id
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

    def self.update_view_count(id)
      query = <<-SQL
      UPDATE jobs
      SET views_count=(SELECT t from (select jobs.views_count as t FROM jobs WHERE id="#{id}") as sub_table)+1
      WHERE id="#{id}"
      SQL
      ActiveRecord::Base.connection.exec_query(query)
      return true
    end

end