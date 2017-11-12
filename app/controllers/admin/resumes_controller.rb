class Admin::ResumesController < ApplicationController

  layout 'admin'

  def record
    @resumeJobships = ResumeJobship.order(id: :desc)
  end
end
