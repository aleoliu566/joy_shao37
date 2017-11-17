class Admin::ArticlesController < ApplicationController
	before_action :set_article, only:[:show,:edit,:update,:audit]
  before_action :set_company, only:[:new,:create]
  before_action :article_params, only:[:update,:create]

  layout 'admin'

	def say
    	@jobs = Job.all
	end

	def index
    @articles_auditing = Article.where(article_status:'auditing')
    @articles_failed = Article.where(article_status:'failed')
    @articles_pass = Article.where(article_status:'pass')
	end

  def edit
    
  end

  def update
    if @article.update(article_params)
      redirect_to admin_articles_path
    else
      redirect_to root_path
    end
  end

  def audit
    if @article.audit params[:article_status]
        redirect_to admin_articles_path
    else
    end
  end

  private

  def article_params
  	params.require(:article).permit(:title, :content)
	end

  def set_company
    @company = Company.find(params[:company_id])
  end

	def set_article
  	@article = Article.find(params[:id])
	end

end
