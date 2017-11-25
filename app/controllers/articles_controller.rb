class ArticlesController < ApplicationController
  def index
    # if params[:search]
    #   @articles = Article.where('title LIKE ?', "%#{params[:search]}%")
    # else
    #   @articles = Article.all
    # end
    # @articles = Article.get_all_article
    
    if params[:search]
      @articles = Article.search_article(params[:search])
    else
      @articles = Article.get_all_article
    end
  end

  def show
    @article = Article.find(params[:id])
    @article.view_count += 1
    @article.save
  end
end
