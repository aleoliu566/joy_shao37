class ResumesController < ApplicationController
  def index
    @resumes = Resume.all
  end

  def new
    @resume = Resume.new

    # @resumes = Resume.where(user_id: current_user.id).order(id: :desc)
    @new_resume = Resume.last
  end

  def create
    @resume = Resume.new(resume_params)
    @resume.user_id = current_user.id

    if @resume.save
      redirect_to new_user_resume_path(current_user.id), notice: "The resume #{@resume.name} has been uploaded."
    else
      render "new"
    end
  end

  # def create
  #   @resume = Resume.new(resume_params)
  #   @resume.user_id = current_user.id

  #   if @resume = Resume.create_resume(current_user.id,resume_params[:name],resume_params[:content],resume_params[:attachment])

  #     redirect_to new_user_resume_path(current_user.id)
  #     # , notice: "The resume #{@resume.name} has been uploaded."

  #   else
  #     render "new"
  #   end
  # end

  def record
    # Resume.where(user_id: current_user.id).ids
    @resumeJobships = ResumeJobship.where(resume_id:Resume.where(user_id: current_user.id).ids).order(id: :desc)
  end

  def destroy
    @resume = Resume.find(params[:id])
    @resume.destroy
    redirect_to resumes_path, notice:  "The resume #{@resume.name} has been deleted."
  end

  private
  def resume_params
    params.require(:resume).permit(:name, :content, :attachment)
  end
end
