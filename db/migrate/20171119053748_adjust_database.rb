class AdjustDatabase < ActiveRecord::Migration[5.1]
  def change
    remove_column :companies, :resume_password
    remove_column :jobs, :year_salary_ceiling
    remove_column :jobs, :year_salary_floor
    remove_column :jobs, :hour_salary_ceiling
    remove_column :jobs, :hour_salary_floor
    add_column :jobs, :salary, :string
  end
end
