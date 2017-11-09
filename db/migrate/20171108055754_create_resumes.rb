class CreateResumes < ActiveRecord::Migration[5.1]
  def change
    create_table :resumes do |t|
      t.string :name
      t.string :content
      t.string :attachment
      
      t.integer :user_id, index: true

      t.timestamps
    end
  end
end
