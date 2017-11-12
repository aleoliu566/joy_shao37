class Resume < ApplicationRecord
  belongs_to :user

  has_many :resume_jobships
  has_many :jobs, :through => :resume_jobships
  
  mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader for this model.
  validates :name, presence: true # Make sure the owner's name is present.
end