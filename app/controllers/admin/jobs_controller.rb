class Admin::JobsController < ApplicationController
  
  layout 'admin'

  def index
    # @jobs = Job.all
    @jobInfos = Job.getJobInfos

    @jobResumes = Job.getJobResumes

  end

  def show
  	 @job = Job.find(params[:id])
  	 @tag = TagJobship.get_job_tag(params[:id])
  end
end
