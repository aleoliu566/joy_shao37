class Admin::JobsController < ApplicationController

  layout 'admin'

  def index
    # @jobs = Job.all

    @jobInfos = Job.getJobInfos

    @jobResumes = Job.getJobResumes

  end

end
