class CompaniesController < ApplicationController
  def home
    @jobs = Job.all
  end
end
