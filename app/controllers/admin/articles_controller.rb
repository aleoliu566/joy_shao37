class Admin::ArticlesController < ApplicationController
	before_action :set_article, only:[:show,:edit,:update,:audit]
  before_action :set_company, only:[:new,:create]
  before_action :article_params, only:[:update,:create]

  layout 'admin'

	def index
    @articles_auditing = Article.admin_get_all_article("auditing")
    @articles_failed =  Article.admin_get_all_article("failed")
    @articles_pass =  Article.admin_get_all_article("pass")
	end

  def edit
    
  end

  def update
    if Article.admin_update_article(params[:id],article_params[:title],article_params[:content])
      @article.update(article_params)
      redirect_to admin_articles_path
    else
     redirect_to root_path
    end
  end

  def audit
    if Article.audit(params[:id],params[:article_status])
        redirect_to admin_articles_path
    else
    end
  end

  private

  def article_params
  	params.require(:article).permit(:title, :content, :banner)
	end

  def set_company
    @company = Company.find(params[:company_id])
  end

	def set_article
  	@article = Article.find(params[:id])
	end

end
