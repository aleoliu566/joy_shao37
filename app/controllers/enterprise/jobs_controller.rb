class Enterprise::JobsController < ApplicationController
  before_action :set_job, only:[:show,:edit,:update,:destroy]
  before_action :set_company, only:[:index,:new,:create,:edit,:update,:destroy]
  before_action :job_params, only:[:update,:create]

  layout 'enterprise'

  def index
    @jobs = Job.get_all_job(@company.id) #沒有current_user令人擔心
  end

  def new
    @job = Job.new
  end

  def create
    #@job = current_user.company.jobs.new(job_params)
    if @job = Job.create_job(@company.id,job_params[:name],job_params[:published_on],job_params[:content],job_params[:hour_salary_ceiling],job_params[:hour_salary_floor])

      redirect_to enterprise_company_jobs_path

    else
      render :action => :new
    end
  end

  def show

  end

  def edit
    
  end

  def update
    if Job.update_job(@job.id,job_params[:name],job_params[:published_on],job_params[:content],job_params[:hour_salary_ceiling],job_params[:hour_salary_floor])

      redirect_to enterprise_company_jobs_path
    else
      render :action => :edit
    end
  end

  def destroy
  #@job.destroy
  Job.delete_job(@job.id)
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
