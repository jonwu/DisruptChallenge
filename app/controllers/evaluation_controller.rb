class EvaluationController < ApplicationController
	def index
		current_rfi = Rfi.find_by(id: params[:rfi_id])
		
		# Check if RFI is from current user
		if current_rfi.user_id == current_user.id 
			collaborators = current_rfi.collaborators

		else
			redirect_to dashboard_index_path
		end
		
	end
end
