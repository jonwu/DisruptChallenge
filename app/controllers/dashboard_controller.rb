class DashboardController < ApplicationController
	respond_to :html, :js
	before_action :authenticate_user!
	
	def index
		@rfis = current_user.rfis.all
		@shared_rfis = Collaborator.find_collaborated_rfis(current_user.id)
		set_current_rfi(@rfis.first)
		@current_rfi = get_current_rfi
	end

	def share_rfi
		p params
		render :json => {success:1}
	end
	
	def page_update 
		rfi_id = params[:rfi_id]
		@current_rfi = Rfi.find_rfi(rfi_id, current_user)
		set_current_rfi(@current_rfi)
		@rfis = current_user.rfis.all
		
	end
	
	private
		$current_rfi

		def set_current_rfi(current_rfi)
		  $current_rfi = current_rfi
		end

		def get_current_rfi
		  return $current_rfi
		end
	
end

