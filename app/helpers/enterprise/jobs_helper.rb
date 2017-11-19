module Enterprise::JobsHelper
	def checked(area)
	  @job.tag.nil? ? false : @job.tag.match(area)
	end	
end
