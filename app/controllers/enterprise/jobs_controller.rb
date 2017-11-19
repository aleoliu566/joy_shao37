class Enterprise::JobsController < ApplicationController
  before_action :set_job, only:[:show,:edit,:update,:destroy]
  before_action :set_company, only:[:index,:new,:create,:edit,:update,:destroy]
  before_action :job_params, only:[:update,:create]

  layout 'enterprise'
  #current_user.company
  def index
    @jobs = Job.hr_get_all_job(params[:company_id]) #沒有current_user令人擔心
  end

  def new
    @job = Job.new
  end

  def create
    #@job = current_user.company.jobs.new(job_params)
    if @job = Job.hr_create_job(params[:company_id],job_params[:name],job_params[:published_on],job_params[:content],job_params[:salary])
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
    if Job.hr_update_job(params[:id],job_params[:name],job_params[:published_on],job_params[:content],job_params[:salary])

      redirect_to enterprise_company_jobs_path
    else
      render :action => :edit
    end
  end

  def destroy
    Job.hr_delete_job(@job.id)
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
    params.require(:job).permit(:name, :published_on, :content, :salary)
  end

end
