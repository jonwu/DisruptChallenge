class QuestionsController < BaseController	
	respond_to :html, :js

	def show
		authenticate_question(params[:id])
		initialize_template
		if request.headers['X-PJAX']
		    render :layout => false
	  	end

	end

	def index
		authenticate_category(params[:category_id])
		initialize_template
	end

	def new
		authenticate_category(params[:category_id])
		initialize_template
	end

end
