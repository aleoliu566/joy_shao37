class CompaniesController < ApplicationController
  before_action :set_company, only:[:show]

  def home
    #更改呼叫 Job Model 中的 get_all_job 方法 （和開放/關閉職缺有關）
    @jobs = Job.get_limit_job #已orderby+limit3
    @companies = Company.get_limit_company
    @articles = Article.get_limit_article


    @resumeJobship = ResumeJobship.new
  end

  def index
    # @companies = Company.all
    if params[:search]
      @companies = Company.search_company(params[:search])
    else
      @companies = Company.get_all_company
    end
  end

  def show
    @jobs = Job.get_job(params[:id])
    #(和hr的方法一樣，取特定公司)
    @company.views_count += 1
    @company.save
    @resumeJobship = ResumeJobship.new
  end

  def favorite
    CompanyFavorite.new_company_fav(current_user.id,params[:company_id])
    flash[:notice] = "您已收藏此公司"
    redirect_back fallback_location: root_path
  end

  def unfavorite
    CompanyFavorite.delete_company_fav(current_user.id,params[:company_id])
    flash[:notice] = "您已取消收藏此公司"
    redirect_back fallback_location: root_path
  end

  def collect
    @jobcollect = JobFavorite.get_all_fav(params[:user_id])
    @companycollect = CompanyFavorite.get_all_fav(params[:user_id])
    @articlecollect = ArticleFavorite.get_all_fav(params[:user_id])
  end

  private
  def set_company
    @company = Company.includes(:jobs).find(params[:id])
  end
end
