class Enterprise::ArticlesController < ApplicationController
  before_action :set_article, only:[:show,:edit,:edit,:update,:destroy]
  before_action :set_company, only:[:index,:new,:create,:edit,:update,:destroy]
  before_action :article_params, only:[:update,:create]

  layout 'enterprise'

  def say
      @jobs = Job.all
  end

  def index
    # @articles = current_user.articles
    @articles = Article.hr_get_all_article(params[:company_id],'pass')
    @article_notyet = Article.hr_get_all_article(params[:company_id],'auditing')
  end

  def new
    @article = Article.new
  end

  def create
      @article = Article.hr_create_article(params[:company_id],current_user.id,article_params[:title],article_params[:content])

      redirect_to enterprise_company_articles_path(current_user.company)

    # else
    #   render :action => :new
    # end
  end

  # def show
    
  # end

  # def create 
  #   query = <<-SQL
  #   insert into articles(title, content)
  #   values ('#{article_params[:title]}','#{article_params[:content]}')
  #   SQL

  #   Article.connection.execute(query)    
  #   redirect_to enterprise_company_articles_path(current_user.company)
  # end

  def edit

  end

  def update
      # Article.hr_update_article(params[:id],article_params[:title],article_params[:content])
      @article.update(article_params)
      redirect_to enterprise_company_articles_path(@company)
    # else
    #   render :action => :edit
    # end
  end

  # def update
  #   query = <<-SQL
  #   update articles
  #   set title = '#{article_params[:title]}', 
  #       content = '#{article_params[:content]}'
  #   where id = '#{@article.id}'
  #   SQL

  #   Article.connection.execute(query)
  #   redirect_to enterprise_company_articles_path(@company)
  # end

  def destroy
    Article.hr_delete_article(params[:id])
    redirect_to enterprise_company_articles_path(@company)
  end

  # def destroy
  #   query = <<-SQL
  #   delete from articles
  #   where id = '#{@article.id}'
  #   SQL

  #   Article.connection.execute(query)
  #   redirect_to enterprise_company_articles_path(@company)
  # end

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
