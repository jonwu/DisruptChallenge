class InvitesController < BaseController
	layout 'main_template'

	def show
		authenticate_rfi(params[:id])
		initialize_template
	end

	def index
		
		redirect_to invite_path(id: current_user.rfis.first)
	end
end
