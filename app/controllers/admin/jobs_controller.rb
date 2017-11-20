class Admin::JobsController < ApplicationController
  
  layout 'admin'

  def index
    @jobs = Job.all

  end
end
