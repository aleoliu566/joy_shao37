class Admin::CompaniesController < ApplicationController
  before_action :set_company, only:[:show,:edit,:update]
  before_action :company_params, only:[:update]

  def home
    @jobs = Job.all
    @company = Company.all
  end

  def index
    
  end

  def show
    
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      redirect_to home_path
    else
    end
  end

  def edit
    
  end

  def update
    if @company.update(company_params)
      redirect_to home_path
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
