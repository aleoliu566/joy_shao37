class Enterprise::JobsController < ApplicationController
  before_action :set_company 
  before_action :set_job, except: [ :new, :create]

  layout 'enterprise'

  def new
    @job = Job.new
  end

  def create
    @job = current_user.company.jobs.new(job_params)

    if @job.save
      redirect_to enterprise_companies_path
    else
      redirect_to root_path
    end
  end

  def edit
    
  end

  def update
    if @job.update(job_params)
      redirect_to enterprise_companies_path
    else
    end
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
