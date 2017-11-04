class CompaniesController < ApplicationController
  def home
    @jobs = Job.all
    @companies = Company.all
  end
end
