class CreateResumeJobships < ActiveRecord::Migration[5.1]
  def change
    create_table :resume_jobships do |t|
      t.text :recommend_letter
      t.integer :resume_id
      t.integer :job_id

      t.timestamps
    end
  end
end
