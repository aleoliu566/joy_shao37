class Enterprise::CompaniesController < ApplicationController

  before_action :set_company, only:[:update]

  layout 'enterprise'

  def index
    @jobs = current_user.company.jobs
    @company = current_user.company
    #Company.hr_get_company(params[:id])
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
      # if Company.hr_update_company(@company.id,company_params[:name],company_params[:phone],company_params[:email],company_params[:address],company_params[:about],company_params[:scale],company_params[:logo])

      redirect_to enterprise_companies_path
    else
      render :action => :edit
    end
  end

  # def update
  #   query = <<-SQL
  #   update companies
  #   set name = '#{company_params[:name]}', 
  #       phone = '#{company_params[:phone]}',
  #       email = '#{company_params[:email]}',
  #       address = '#{company_params[:address]}',
  #       about = '#{company_params[:about]}'
  #   where id = '#{@company.id}'
  #   SQL

  #   Company.connection.execute(query)
  #   redirect_to enterprise_companies_path
  # end

  def check_resume
    
  end

  def set_hr
    if User.find_by(id: params[:user])
      User.find_by(id: params[:user]).update(company_id: params[:company_id])
      redirect_to home_path
    else
      redirect_to home_path
    end
  end

  def remove_hr
    if User.find_by(id: params[:user_id])
      User.find_by(id: params[:user_id]).update(company_id: nil)
      redirect_to home_path
    else
      redirect_to home_path
    end    
  end


  private
  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :phone, :email, :address, :about, :user_ids ,:scale ,:logo)
  end
  
end
