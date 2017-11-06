class CompaniesController < ApplicationController
  def home
    @jobs = Job.all
    @companies = Company.find_by_sql("SELECT * FROM companies")
  end
end
