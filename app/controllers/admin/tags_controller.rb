class Admin::TagsController < ApplicationController
    before_action :set_tag, only:[:edit,:update,:destroy]
    before_action :tag_params, only:[:update,:create]
    layout 'admin'


  def index
    	@tags = Tag.get_all_tags
  end


	def new
	    @tag = Tag.new   
	end
	
	def create     
      Tag.create_tag(tag_params[:name])
      if 
      redirect_to admin_tags_path
      else
      render :action => :new
      end 
	end

  def destroy 
    begin 
	    Tag.delete_tag(params[:id])
      TagJobship.delete_tagjob(params[:id])
    rescue NoMethodError => e
	    redirect_to admin_tags_path
    end
  end

  def edit
  		
  end

  def update
      Tag.update_tag(tag_params[:name],params[:id])
      if
      redirect_to admin_tags_path
      else
      render :action => :edit
      end
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end

    
end