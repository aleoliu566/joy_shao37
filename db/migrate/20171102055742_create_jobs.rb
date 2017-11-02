class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :name
      t.date :published_on
      t.text :content
      t.string :status
      t.integer :views_count, :default => 0
      t.integer :company_id
      t.integer :year_salary_ceiling
      t.integer :year_salary_floor
      t.integer :hour_salary_ceiling
      t.integer :hour_salary_floor

      t.timestamps
    end
  end
end
