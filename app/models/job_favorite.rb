class JobFavorite < ApplicationRecord
	belongs_to :user
  	belongs_to :job

  	#READ USER FAV
     def self.get_all_fav(uid)
     # 把sql寫在這邊
     query = <<-SQL
     SELECT jobs.id AS jobId , jobs.name AS jobName , companies.name AS companyName
     FROM jobs,job_favorites,users,companies
     WHERE jobs.id = job_favorites.job_id AND users.id = job_favorites.user_id AND companies.id = jobs.company_id AND job_favorites.user_id = "#{uid}" 
     ORDER BY jobs.company_id
     SQL
     self.find_by_sql(query)
     end

     # SELECT jobs.id AS jobId , jobs.name AS jobName , companies.name AS companyName
     # FROM job_favorites
     # INNER JOIN jobs on jobs.id = job_favorites.job_id
     # INNER JOIN users on jobs.id = job_favorites.user_id
     # INNER JOIN companies on companies.id = jobs.company_id 
     # WHERE job_favorites.user_id = "#{uid}" 

     # SELECT jobs.id AS jobId , jobs.name AS jobName , companies.name AS companyName
     # FROM job_favorites
     # JOIN jobs,users,companies
     # ON jobs.id = job_favorites.job_id AND users.id = job_favorites.user_id AND companies.id = jobs.company_id 
     # WHERE job_favorites.user_id = "#{uid}" 

     def self.new_job_fav(uid,jid)
     t = DateTime.now.strftime('%Y-%m-%d %H:%M:%S')
     query = <<-SQL
     INSERT INTO job_favorites(user_id,job_id,created_at,updated_at)
     VALUES ("#{uid}","#{jid}","#{t}","#{t}")
     SQL
     ActiveRecord::Base.connection.exec_query(query)
     end

     def self.delete_job_fav(uid,jid)
     t = DateTime.now.strftime('%Y-%m-%d %H:%M:%S')
     query = <<-SQL
     DELETE FROM job_favorites
     WHERE user_id = "#{uid}" AND job_id = "#{jid}"
     SQL
     ActiveRecord::Base.connection.exec_query(query)
     end


end
