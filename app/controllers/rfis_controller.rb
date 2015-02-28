class RfisController < BaseController

	def show
		authenticate_rfi(params[:id])
		initialize_template
		if request.headers['X-PJAX']
    	render :layout => false
  	end
	end

	def index
		redirect_to rfi_path(id: current_user.rfis.first)
		
	end

	def share

		
		if collaborator_user != nil 
			# Collaborator's user id
			user_id = collaborator_user.id	
			rfi_id = get_current_rfi.id
			collaborator = Collaborator.find_or_create_by(user_id: user_id , rfi_id: rfi_id)
			if !collaborator.nil?
				questions = get_current_rfi.questions
				Response.set_empty_responses(questions, [collaborator])
			end

		else
			
		end

		render nothing: true
	end

	

end
