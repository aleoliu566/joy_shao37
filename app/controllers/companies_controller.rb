class CompaniesController < ApplicationController
  def home
    @jobs = Job.all
    @companies = Company.get_all_company
    # @companies = Company.find_by_sql("SELECT * FROM companies")
  end
end
