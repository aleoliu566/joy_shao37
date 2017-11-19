class CompaniesController < ApplicationController
  def home
    @jobs = Job.all
    @companies = Company.all
  end

  def collect
    
  end
end
