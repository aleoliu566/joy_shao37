class Admin::CompaniesController < ApplicationController
  before_action :set_company, only:[:show,:edit,:update]
  before_action :company_params, only:[:update]

  before_action :authenticate_admin

  layout 'admin'

  def home
    # @jobs = Job.get_all_job
    @company = Company.adminGetCompanyList
  end

  def index
  end

  def show
    
  end

  def new
    @company = Company.new
  end

  # def create
  #   @company = Company.new(company_params)

  #   if @company.save
  #     redirect_to home_path
  #   else
  #   end
  # end

  def create
    @company = Company.admin_create_company(company_params[:name],company_params[:phone],company_params[:email],company_params[:address],company_params[:about],company_params[:scale])

    redirect_to home_path
  end

  def edit
    
  end

  # def update
  #   if @company.update(company_params)
  #     redirect_to home_path
  #   else
  #     redirect_to root_path
  #   end
  # end

  def update
    @company.update(company_params)
      # Company.admin_update_company(@company.id,company_params[:name],company_params[:phone],company_params[:email],company_params[:address],company_params[:about])

    redirect_to home_path
  end

  # # 刪除寫在這
  # def destroy
  #   @company = Company.find(params[:id])
  #   if @company.destroy
  #     redirect_to home_path
  #   else
  #   end
  # end

  def destroy
    Company.admin_delete_company(params[:id])
    redirect_to home_path
  end

  def ban
    @company = Company.find(params[:id])
    if @company.ban
        redirect_to home_path
    else
    end
  end



  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :phone, :email, :address, :about,:user_ids,:scale)
  end

end
