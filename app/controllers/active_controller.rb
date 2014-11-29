class ActiveController < ApplicationController
	layout "admin"

	def index
		rfi_id = params[':rfi_id']
		@rfis = current_user.rfis.all
		@shared_rfis = Collaborator.find_collaborated_rfis(current_user.id)
		@current_page = "active_rfis"
		@current_rfi = nil
		# set_current_rfi(nil)
		# render :index
	end
end
