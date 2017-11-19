class Tag < ApplicationRecord
  has_many :tag_jobships
  has_many :jobs, :through => :tag_jobships, dependent: :destroy


  def self.get_all_tags()

  	 query = <<-SQL
  	 	SELECT *
  	 	FROM tags
  	 SQL
  	 self.find_by_sql(query)
  end	


end
