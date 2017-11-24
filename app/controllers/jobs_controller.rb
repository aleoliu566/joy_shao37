class JobsController < ApplicationController
  before_action :set_job, except:[:index]
  before_action :set_company, only:[:apply,:check_resume]

  def index
    #更改呼叫 Job Model 中的 get_all_job 方法 （和開放/關閉職缺有關）
    @jobs = Job.get_all_job 
  end

  def show
    @tag = TagJobship.get_job_tag(params[:id])
    @job.views_count += 1
    @job.save
  end

  def check_resume
    @resume = Resume.first
    @resumeJobship = ResumeJobship.new
  end

  def apply
    @resumeJobship = ResumeJobship.new(resumeJobship_params)

    @resumeJobship.resume_id = current_user.resumes.last.id
    @resumeJobship.job_id = @job.id

    puts @resumeJobship

    if @resumeJobship.save
      redirect_to root_path
    else
      render 'check_resume'
    end
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def set_company
    @company = Company.find(params[:company_id])
  end

  def resumeJobship_params
    params.require(:resume_jobship).permit(:recommend_letter, :company_id, :id)
  end

end
