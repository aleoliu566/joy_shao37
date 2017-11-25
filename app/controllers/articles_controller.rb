class ArticlesController < ApplicationController
  def index
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

  def favorite
    ArticleFavorite.new_article_fav(current_user.id,params[:id])
    flash[:notice] = "您已收藏此文章"
    redirect_back fallback_location: root_path
  end

  def unfavorite
    ArticleFavorite.delete_article_fav(current_user.id,params[:id])
    flash[:notice] = "您已取消收藏此文章"
    redirect_back fallback_location: root_path
  end

end
