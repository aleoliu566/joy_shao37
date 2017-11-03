class Admin::ArticlesController < ApplicationController
	before_action :set_company, only:[:show,:edit,:update]
  	before_action :company_params, only:[:update]

  	layout 'admin'

	def say
    	@jobs = Job.all
	end

	def index
	    
	end

	def new

  	end

  	def create
    	@article = Article.new(article_params)

    	if @article.save
      		redirect_to home_path
    	else
    	end
    end

    private

    def article_params
    	params.require(:article).permit(:name, :phone, :email, :address, :about, :user_ids)
  	end

  	def set_company
    	@article = Article.find(params[:id])
  	end

end
