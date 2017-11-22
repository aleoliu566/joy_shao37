class ChangeToFk < ActiveRecord::Migration[5.1]
  def change
    add_index :jobs, :company_id
    add_index :resume_jobships, :resume_id
    add_index :resume_jobships, :job_id
    add_index :tag_jobships, :job_id
    add_index :tag_jobships, :tag_id
  end
end
