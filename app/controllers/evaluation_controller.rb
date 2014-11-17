class EvaluationController < ApplicationController
	def index
		p "*"*80
		p params[:collaborator_id]

		collaborator = Collaborator.find_by(id: params[:collaborator_id])
		p collaborator.rfi
		if !collaborator.nil? && (current_user.id == collaborator.rfi.user_id)
			
		else
			redirect_to dashboard_index_path
		end
		
	end
end
