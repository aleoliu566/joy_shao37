class JobsController < ApplicationController
  before_action :set_job, except:[:index]
  before_action :set_company, only:[:apply,:check_resume]
  before_action :authenticate_user!, only: [:favorite, :unfavorite]

  def index
    #更改呼叫 Job Model 中的 get_all_job 方法 （和開放/關閉職缺有關）
    if params[:search]
       @jobs = Job.search_job(params[:search])
    else
       @jobs = Job.get_all_job
    end

    @resumeJobship = ResumeJobship.new
  end

  def show
    #@job = Job.get_detail_job(params[:id])
    @jobs = Job.get_a_job(@job.company_id,params[:id])
    Job.update_view_count(params[:id])
    @tag = TagJobship.get_job_tag(params[:id])

    @resumeJobship = ResumeJobship.new
  end

  def check_resume
    @resume = Resume.first
    @resumeJobship = ResumeJobship.new
    @company = Company.find(params[:company_id])
    @job = Job.find(params[:id])
  end

  def apply
    @resumeJobship = ResumeJobship.new(resumeJobship_params)

    @resumeJobship.resume_id = current_user.resumes.last.id
    @resumeJobship.job_id = @job.id

    if @resumeJobship.save
      redirect_to root_path
    else
      render 'check_resume'
    end
  end

  def favorite
    JobFavorite.new_job_fav(current_user.id,params[:id])
    flash[:notice] = "您已收藏此職缺"
    redirect_back fallback_location: root_path
  end
  def unfavorite
    JobFavorite.delete_job_fav(current_user.id,params[:id])
    flash[:notice] = "您已取消收藏此職缺"
    redirect_back fallback_location: root_path
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def set_company
    @company = Company.find(params[:company_id])
  end

  def resumeJobship_params
    # params.require(:resume_jobship).permit(:recommend_letter, :company_id, :id)
  end

end
