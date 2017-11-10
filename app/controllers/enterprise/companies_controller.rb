class Enterprise::CompaniesController < ApplicationController

  before_action :set_company, only:[:update]

  layout 'enterprise'

  def index
    @jobs = current_user.company.jobs
    @company = current_user.company
  end

  def new
    @company = current_user.company
  end

  def create
     @job = Job.new
  end

  def edit
    @company = current_user.company
  end

  def update
    if @company.update(company_params)
      redirect_to enterprise_companies_path
    else
      redirect_to root_path
    end
  end

  private
  
  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :phone, :email, :address, :about, :user_ids)
  end
  
end
