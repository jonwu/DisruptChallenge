class DashboardController < ApplicationController
	before_action :authenticate_user!
	
	def index
    @rfis = current_user.rfis.all
    @shared_rfis = Collaborator.find_collaborated_rfis(current_user.id)
	end

end
