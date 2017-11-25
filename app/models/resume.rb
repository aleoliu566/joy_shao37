class Resume < ApplicationRecord
  belongs_to :user

  has_many :resume_jobships
  has_many :jobs, :through => :resume_jobships
  
  mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader for this model.
  # validates :name, presence: true # Make sure the owner's name is present.


    # #CREATE
    # def self.create_resume(uid,name,content,attachment)
    #   t = DateTime.now
    #   query = <<-SQL
    #   INSERT INTO resumes(user_id,name,content,attachment,created_at,updated_at)
    #   VALUES ("#{uid}","#{name}","#{content}","#{attachment}","#{t}","#{t}")
    #   SQL
    #   self.find_by_sql(query)
    # end


end
