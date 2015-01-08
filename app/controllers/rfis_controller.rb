class RfisController < BaseController
	layout 'main_template'
	skip_before_filter :authenticate_category
	skip_before_filter :authenticate_question

	def show
		
	end

	def index

		if !params[:shared].nil? && params[:shared]
			redirect_to rfi_path(rfi_id: current_user.rfis.first, shared: true)
		else
			redirect_to rfi_path(rfi_id: current_user.rfis.first)
		end
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
