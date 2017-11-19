class TagJobship < ApplicationRecord
  belongs_to :tag
  belongs_to :job

  def self.get_job_tag(jid)
   query = <<-SQL
  	 	SELECT tag_id, tags.name
  	 	FROM tag_jobships, tags
  	 	WHERE job_id = "#{jid}" AND tag_jobships.tag_id = tags.id
  	SQL
  	self.find_by_sql(query)
  end

end
