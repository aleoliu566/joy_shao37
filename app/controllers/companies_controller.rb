class CompaniesController < ApplicationController
  before_action :set_company, only:[:show]

  def home
    @jobs = Job.all
    @companies = Company.all
  end

  def show
    @company.views_count += 1
    @company.save
  end

  def collect
    
  end

  private
  def set_company
    @company = Company.includes(:jobs).find(params[:id])
  end
end
