class CreateTagJobships < ActiveRecord::Migration[5.1]
  def change
    create_table :tag_jobships do |t|
    	t.integer :job_id
    	t.integer :tag_id

    	t.timestamps
    end
  end
end
