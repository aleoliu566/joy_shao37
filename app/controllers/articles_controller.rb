class ArticlesController < ApplicationController
  def index
    @articles = Article.get_all_article
  end

  def show
    @article = Article.find(params[:id])
    @article.view_count += 1
    @article.save
  end
end
