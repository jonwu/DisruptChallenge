class DashboardController < ApplicationController
	respond_to :html, :js
	before_action :authenticate_user!


	
	def index
		@rfis = current_user.rfis.all
		@shared_rfis = Collaborator.find_collaborated_rfis(current_user.id)
		
		set_current_rfi(@rfis.first)
		@current_rfi = get_current_rfi
		
		@collaborators = Collaborator.get_collaborators(@current_rfi)
	end

	def share_rfi
		collaborator = User.find_by(email:params[:email])
		if collaborator != nil
			collaborator_id = User.find_by(email:params[:email]).id	
			rfi_id = get_current_rfi.id
			Collaborator.new_collaborator(collaborator_id,rfi_id)
			questions = get_current_rfi.questions
			Response.set_empty_responses(questions, collaborator_id)
		end
		render :json => {success:1}
	end

	def delete_rfi
		Rfi.delete_rfi(get_current_rfi.id)
		set_current_rfi(current_user.rfis.first)
		redirect_to action: 'page_update'
	end

	def navigate_rfi
		rfi_id = params[:rfi_id]
		current_rfi = Rfi.find_rfi(rfi_id, current_user)
		set_current_rfi(current_rfi)
		redirect_to action: 'page_update'
	end

	def page_update 
		@current_rfi = get_current_rfi
		@rfis = current_user.rfis.all
		@shared_rfis = Collaborator.find_collaborated_rfis(current_user.id)
		@collaborators = Collaborator.get_collaborators(@current_rfi)
		
	end

	def make_title_form
		@current_rfi = get_current_rfi
	end
	def update_rfi_title
		get_current_rfi.update(:title => params[:rfi_title])
		redirect_to action: 'page_update'
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

