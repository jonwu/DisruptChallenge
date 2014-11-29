class DashboardController < ApplicationController
	respond_to :html, :js
	before_action :authenticate_user!
	

	def dashboard
		set_current_page("dashboard")
		set_current_rfi(nil)
		redirect_to action: 'page_update'
	end

	def active_rfis
		set_current_page("active_rfis")
		set_current_rfi(current_user.rfis.first)
		redirect_to action: 'page_update'
	end
	
	def index
		@rfis = current_user.rfis.all
		@shared_rfis = Collaborator.find_collaborated_rfis(current_user.id)
		@current_page = set_current_page("dashboard")
		set_current_rfi(nil)
		@current_rfi = get_current_rfi

	end

	def share_rfi
		collaborator_user = User.find_by(email:params[:email])
		if collaborator_user != nil
			# Collaborator's user id
			user_id = collaborator_user.id	
			rfi_id = get_current_rfi.id
			collaborator = Collaborator.new_collaborator(user_id,rfi_id)
			questions = get_current_rfi.questions
			
			if !collaborator.nil?
				Response.set_empty_responses(questions, [collaborator])
			end
		end
		redirect_to action: 'page_update'
	end

	def delete_rfi
		Rfi.delete_rfi(get_current_rfi.id)
		set_current_rfi(current_user.rfis.first)
		redirect_to action: 'page_update'
	end

	def navigate_rfi
		set_current_page("active_rfis")
		rfi_id = params[:rfi_id]
		current_rfi = Rfi.find_rfi(rfi_id, current_user)
		set_current_rfi(current_rfi)
		redirect_to action: 'page_update'
	end

	def page_update 
		@current_rfi = get_current_rfi
		@current_page = get_current_page
		@rfis = current_user.rfis.all
		@shared_rfis = Collaborator.find_collaborated_rfis(current_user.id)
		@collaborator = nil;
		@collaborators_scores = []	
		@collaborators_names = []

		if @current_page == "active_rfis"
			@collaborators = get_current_rfi.collaborators
			@sorted_collaborators = @collaborators.order_by_score
			
			for collaborator in @sorted_collaborators
				if collaborator.submissions.is_null.count == 0
					@collaborators_names.push(collaborator.user.name)
					@collaborators_scores.push(collaborator.total_score)
				end
			end 
		end

		
		
	end

	def make_title_form
		@current_rfi = get_current_rfi
	end

	def update_rfi_title
		get_current_rfi.update(:title => params[:rfi_title])
		redirect_to action: 'page_update'
	end

	def load_charts
		# need all collaborators to render check boxes
		
		# p @collaborator_names
		# p @collaborator_scores
		# @categories = get_current_rfi.categories
		# @empty_categories = []
		# (1..@categories.count).each do |i|
		# 	@empty_categories.push(0)
		# end
		# for collaborator in @collaborators
		# 	hash = {}
			
		# 	# @collaborator_names.push(collaborator.user.email)
		# 	# @collaborator_scores.push(collaborator.submissions.sum(:score))
		# 	if (collaborator.selected)
		# 		collab_scores = Submission.calculate_score_for_all_categories(@categories, collaborator)
		# 		hash["score"] = collab_scores
		# 		hash["selected"] = true
		# 	else
		# 		hash["selected"] = false
		# 	end
		# 	hash["label"] = collaborator.user.email
		# 	hash["collaborator"] = collaborator
		# 	@collaborator_scores.push(hash)
		# end
		render :nothing => true
	end

	def load
		@collaborator_names = []
		@collaborator_scores = []

	end

	def update_selected
		collaborator_id = params[:collaborator_id]
		is_selected = params[:is_selected]
		Collaborator.find_by_id(collaborator_id).update(selected: is_selected)
		redirect_to action: 'load_charts'
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

