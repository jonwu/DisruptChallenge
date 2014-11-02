class DashboardController < ApplicationController
	before_action :authenticate_user!
	def index

	end

	def create_rfi
		p "*"*90
		user_id = current_user.id
		@rfi = Rfi.new(user_id: user_id)
		@rfi.save
	end
end
