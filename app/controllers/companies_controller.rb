class CompaniesController < ApplicationController
  def home
  	#更改呼叫 Job Model 中的 get_all_job 方法 （和開放/關閉職缺有關）
    @jobs = Job.get_all_job
    @companies = Company.all
  end
end
