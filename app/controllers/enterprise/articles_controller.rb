class Enterprise::ArticlesController < ApplicationController
  before_action :set_article, only:[:show,:edit,:update]
  before_action :set_company, only:[:new,:create]
  before_action :article_params, only:[:update,:create]

  layout 'enterprise'

  def say
      @jobs = Job.all
  end

  def index
    @articles = current_user.articles
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    @article.company_id = @company.id
    
    if @article.save
      redirect_to enterprise_company_articles_path(current_user.company)
    else
      render 'admin/articles/new'
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

