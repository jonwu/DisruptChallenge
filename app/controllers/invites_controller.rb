class InvitesController < BaseController

	def show
    authenticate_vendor(params[:id])
		initialize_template
	end

	def index
		
		redirect_to invite_path(id: current_user.rfis.first)
	end
end
