class CompaniesController < ApplicationController
  before_action :set_company, only:[:show]

  def home
  	#更改呼叫 Job Model 中的 get_all_job 方法 （和開放/關閉職缺有關）
    @jobs = Job.get_all_job
    @companies = Company.all
    @articles = Article.order(view_count: :desc)
  end

  def index
    # @companies = Company.all

    if params[:search]
      @companies = Company.where('name LIKE ?', "%#{params[:search]}%")
    else
      @companies = Company.all
    end
  end

  def show
    @jobs = Job.get_job(params[:id])
    #(和hr的方法一樣，取特定公司)
    @company.views_count += 1
    @company.save
  end

  def collect
    
  end

  private
  def set_company
    @company = Company.includes(:jobs).find(params[:id])
  end
end
