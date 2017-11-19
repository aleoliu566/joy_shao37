class ArticlesController < ApplicationController
<<<<<<< HEAD
end
=======
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end
end
>>>>>>> user端文章頁面
