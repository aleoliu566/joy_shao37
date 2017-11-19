class CompaniesController < ApplicationController
  before_action :set_company, only:[:show]

  def home
  	#更改呼叫 Job Model 中的 get_all_job 方法 （和開放/關閉職缺有關）
    @jobs = Job.get_all_job
    @companies = Company.all
  end

  def show
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
