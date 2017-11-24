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
  
  def is_fan_of?(group)
    favorite_userjobs.include?(group)

    # query = <<-SQL
    # SELECT 
    # INNER JOIN


    # SQL
    # ActiveRecord::Base.connection.exec_query(query)

  end

  def admin?
    self.role == 1
  end

end
