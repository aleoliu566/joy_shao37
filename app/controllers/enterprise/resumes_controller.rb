class Enterprise::ResumesController < ApplicationController
  before_action :set_company

  layout 'enterprise'
  
  def record
    @resumeJobships = ResumeJobship.where(job_id:Job.where(company_id: @company.id).ids).order(id: :desc)
  end


  private

  def set_company
    @company = Company.find(params[:company_id])
  end
end
