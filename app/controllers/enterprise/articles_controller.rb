class Enterprise::ArticlesController < ApplicationController
  before_action :set_article, only:[:show,:edit,:edit,:update,:destroy]
  before_action :set_company, only:[:index,:new,:create,:edit,:update,:destroy]
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


  # def update
  #   if @article.update(article_params)
  #     redirect_to enterprise_company_articles_path(@company)
  #   else
  #   end
  # end

  def update
    query = <<-SQL
    update articles
    set title = '#{article_params[:title]}', 
        content = '#{article_params[:content]}'
    where id = '#{@article.id}'
    SQL

    Article.connection.execute(query)
    redirect_to enterprise_company_articles_path(@company)
  end

  # def destroy
  #   @article.destroy
  #   redirect_to enterprise_company_articles_path
  # end

  def destroy
    query = <<-SQL
    delete from articles
    where id = '#{@article.id}'
    SQL

    Article.connection.execute(query)
    redirect_to enterprise_company_articles_path(@company)
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
