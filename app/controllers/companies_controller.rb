class CompaniesController < ApplicationController
  def home
    @jobs = Job.all
    @companies = Company.get_all_company
  end
end
