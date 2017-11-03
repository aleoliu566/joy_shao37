class Article < ApplicationRecord
	has_many :jobs
  	has_many :users
end
