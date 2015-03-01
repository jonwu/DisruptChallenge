class RfisController < BaseController

	def show
		authenticate_rfi(params[:id])
		initialize_template
		if request.headers['X-PJAX']
    	render :layout => false
  	end
	end

	def index
		redirect_to rfi_path(id: current_user.rfis.first)
		
	end

	def create
    rfi = Rfi.create!( user_id: current_user.id, title: params[:rfi_title]) 
    Category.create!( rfi_id: rfi.id,
                  		text: "New Category")
    redirect_to rfi_path(id: rfi.id)
	end

	def update
    authenticate_rfi(params[:id])
		new_name = params[:rfi_title]
		@current_rfi = get_current_rfi
    # only update if the name actually changed
    if @current_rfi.title.to_s != new_name.to_s
      @current_rfi.update_attributes(:title => new_name)
    end
    redirect_to rfi_path(id: @current_rfi.id)
	end

  def destroy
    authenticate_rfi(params[:id])
    Rfi.destroy(get_current_rfi.id)
    current_rfi = get_rfis.first
    redirect_to rfi_path(id: current_rfi.id)
  end

	def share

		
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
			
		end

		render nothing: true
	end

	

end
