class DashboardController < ApplicationController
	respond_to :html, :js
	before_action :authenticate_user!

	def dashboard
		set_current_page("dashboard")
		set_current_rfi(nil)
		redirect_to dashboard_page_update_path
	end

	def active_rfis
		set_current_page("active_rfis")
		set_current_rfi(current_user.rfis.first)
		redirect_to dashboard_page_update_path
	end
	
	def index
		@rfis = current_user.rfis
		@shared_rfis = Rfi.find_collaborated_rfis(current_user.id)
		set_current_page("dashboard")
		set_current_rfi(nil)
		@current_rfi = get_current_rfi
		@activities = PublicActivity::Activity.order("created_at desc")
	end

	def share_rfi
		collaborator_user = User.find_by(email: params[:email])
		if collaborator_user != nil
			# Collaborator's user id
			user_id = collaborator_user.id	
			rfi_id = get_current_rfi.id
			collaborator = Collaborator.find_or_create_by(user_id: user_id , rfi_id: rfi_id)
			if !collaborator.nil?
				questions = get_current_rfi.questions
				Response.set_empty_responses(questions, [collaborator])
			end
		else
			# invite new user
			p '*' * 80
			User.invite!(:email => params[:email])
		end
		redirect_to dashboard_page_update_path
	end

	def delete_rfi
		Rfi.delete_rfi(get_current_rfi.id)
		set_current_rfi(current_user.rfis.first)
		redirect_to dashboard_page_update_path
	end

	def navigate_rfi
		set_current_page("active_rfis")
		current_rfi = Rfi.find_rfi(params[:rfi_id], current_user)
		set_current_rfi(current_rfi)
		redirect_to dashboard_page_update_path
	end

	def page_update 
		@current_rfi = get_current_rfi
		@current_page = get_current_page
		@rfis = current_user.rfis
		@shared_rfis = Rfi.find_collaborated_rfis(current_user.id)
		@collaborators_scores = []	
		@collaborators_names = []

		if @current_page == "active_rfis" && !@current_rfi.nil? 
			@collaborators = Collaborator.where(rfi_id: @current_rfi.id).all
			sorted_collaborators = Collaborator.sort_by_score(@collaborators)
			sorted_collaborators.each do |collaborator_id, score|
				@collaborators_names.push(Collaborator.find_by_id(collaborator_id).user.name)
				@collaborators_scores.push(score)
			end 
		end
	end

	def make_title_form
		@current_rfi = get_current_rfi
	end

	def update_rfi_title
		get_current_rfi.update(:title => params[:rfi_title])
		redirect_to dashboard_page_update_path
	end
	
	private
		$current_rfi
		$current_page

		def set_current_rfi(current_rfi)
		  $current_rfi = current_rfi
		end

		def get_current_rfi
		  return $current_rfi
		end

		def set_current_page(current_page)
		  $current_page = current_page
		end

		def get_current_page
		  return $current_page
		end
	
end

