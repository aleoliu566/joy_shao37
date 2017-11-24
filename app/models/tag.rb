class Tag < ApplicationRecord
  has_many :tag_jobships
  has_many :jobs, :through => :tag_jobships, dependent: :destroy

  ##### ADMIN #######

  #CREATE JOB
  def self.create_tag(name)
      t = DateTime.now.strftime('%Y-%m-%d %H:%M:%S')
      query = <<-SQL
      INSERT INTO tags(name,created_at,updated_at)
      VALUES ("#{name}","#{t}","#{t}")
      SQL
      ActiveRecord::Base.connection.exec_query(query)
  end

  #READ TAG
  def self.get_all_tags
  	 query = <<-SQL
      SELECT tags.*, COUNT(tag_jobships.tag_id) AS count
      FROM tag_jobships
      RIGHT JOIN tags ON tags.id = tag_jobships.tag_id
      LEFT JOIN jobs ON jobs.id = tag_jobships.job_id
      LEFT JOIN companies ON companies.id = jobs.company_id 
      WHERE account_status IS NULL OR account_status = "open"
      GROUP BY tags.id

  	 SQL
  	 self.find_by_sql(query)
  end	

  #DELETE TAG
  def self.delete_tag(id)
  	 query = <<-SQL
  	 	DELETE FROM tags
  	 	WHERE tags.id = "#{id}"
  	 SQL
  	 ActiveRecord::Base.connection.exec_query(query)
  end	

  #UPDATE
  def self.update_tag(name,id)
      t = DateTime.now.strftime('%Y-%m-%d %H:%M:%S')
      query = <<-SQL
      UPDATE tags
      SET name = "#{name}", updated_at = "#{t}"
      WHERE id = "#{id}"
      SQL
      ActiveRecord::Base.connection.exec_query(query)
  end

  ##### ADMIN #######

end
