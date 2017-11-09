class Enterprise::JobsController < ApplicationController
  before_action :set_job, only:[:show,:edit,:update,:edit,:destroy]
  before_action :set_company, only:[:index,:new,:create,:edit,:update,:destroy]
  before_action :job_params, only:[:update,:create]

  layout 'enterprise'

  def index
    @jobs = Job.get_all_job(params[:company_id]) #沒有current_user令人擔心
  end

  def new
    @job = Job.new
  end

  def create
    @job = current_user.company.jobs.new(job_params)
    #@job = Job.create_job(:name,:published_on, :content, :hour_salary_ceiling, :hour_salary_floor)

    if @job.save
      redirect_to enterprise_company_jobs_path
    else
      render :action => :new
    end
  end

  def edit
    
  end

  def update
    if @job.update(job_params)
      redirect_to enterprise_company_jobs_path
    else
      render :action => :edit
    end
  end

  def destroy

  @job.destroy
  redirect_to enterprise_company_jobs_path
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:name, :published_on, :content, :hour_salary_ceiling, :hour_salary_floor )
  end

end
