class DashboardController < ApplicationController
	before_action :authenticate_user!
	def index
    @rfis = current_user.rfis.all
	end

end
