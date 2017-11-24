class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :company, optional: true
  has_many :articles
  has_many :resumes
  has_many :job_favorites
  has_many :favorite_userjobs, :through => :job_favorites, :source => :job
  has_many :company_favorites
  has_many :favorite_usercompanies, :through => :company_favorites, :source => :company

  def is_company_fan_of?(group,user)
    #favorite_usercompanies.include?(group)
    query = <<-SQL
    SELECT company_id
    FROM company_favorites
    WHERE user_id = "#{user}" AND company_id = "#{group}"
    SQL
    ActiveRecord::Base.connection.exec_query(query)
  end
  
  def is_fan_of?(group,user)
    query = <<-SQL
    SELECT job_id
    FROM job_favorites
    WHERE user_id = "#{user}" AND job_id = "#{group}"
    SQL
    ActiveRecord::Base.connection.exec_query(query)
  end

  def admin?
    self.role == 1
  end

end
