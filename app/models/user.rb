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
  has_many :article_favorites
  has_many :favorite_userarticles, :through => :article_favorites, :source => :article

  validates_presence_of :birthday

  def is_article_fan_of?(group,user)
    query = <<-SQL
    SELECT article_id
    FROM article_favorites
    WHERE user_id = "#{user}" AND article_id = "#{group}"
    SQL
    ActiveRecord::Base.connection.exec_query(query)
  end

  def is_company_fan_of?(group,user)
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

  def self.all_user
    query = <<-SQL
    SELECT *
    FROM users
    SQL
  end

  def self.is_admin
    query = <<-SQL
    SELECT *
    FROM users
    WHERE role = 1
    SQL
    self.find_by_sql(query)    
  end

  def self.set_admin(user_email)
    query = <<-SQL
    UPDATE users
    SET role = 1
    WHERE email = "#{user_email}"
    SQL
    ActiveRecord::Base.connection.exec_query(query)
  end

  def self.remove_admin(user_email)
    query = <<-SQL
    UPDATE users
    SET role = 0
    WHERE email = "#{user_email}"
    SQL
    ActiveRecord::Base.connection.exec_query(query)
  end

  #UPDATE_admin
  def self.admin_update_article(a,title,content)
    t = DateTime.now.strftime('%Y-%m-%d %H:%M:%S')
    query = <<-SQL
    UPDATE articles 
    SET title = "#{title}", content = "#{content}", updated_at="#{t}"
    WHERE id = "#{a}"
    SQL
    a_u_article = ActiveRecord::Base.connection.exec_query(query)
  end

  def admin?
    self.role == true
  end

end
