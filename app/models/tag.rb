class Tag < ApplicationRecord
  has_many :tag_jobships
  has_many :jobs, :through => :tag_jobships, dependent: :destroy

  ##### ADMIN #######

  #CREATE JOB
  def self.create_tag(name)
      t = DateTime.now
      query = <<-SQL
      INSERT INTO tags(name,created_at,updated_at)
      VALUES ("#{name}","#{t}","#{t}")
      SQL
      self.find_by_sql(query)
  end

  #READ TAG
  def self.get_all_tags
  	 query = <<-SQL
  	 	SELECT *
  	 	FROM tags
  	 SQL
  	 self.find_by_sql(query)
  end	

  #DELETE TAG
  def self.delete_tag(id)
  	 query = <<-SQL
  	 	DELETE FROM tags 
  	 	WHERE id = "#{id}"
  	 SQL
  	 self.find_by_sql(query)
  end	

  #UPDATE
  def self.update_tag(name,id)
      t = DateTime.now
      query = <<-SQL
      UPDATE tags
      SET name = "#{name}", updated_at = "#{t}"
      WHERE id = "#{id}"
      SQL
      self.find_by_sql(query)
  end

  ##### ADMIN #######

end
