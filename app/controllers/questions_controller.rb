class QuestionsController < BaseController	
	respond_to :html, :js
	before_filter :authenticate_params
  	
  	def authenticate_params
    	if params.has_key?(:category_id)
    		authenticate_category(params[:category_id])
    	elsif params.has_key?(:id)
    		authenticate_question(params[:id])
    	end
    	initialize_template

  	end
	
  	
	def show
		if request.headers['X-PJAX']
    		render :layout => false
  		end

	end

	def index
		if request.headers['X-PJAX']
    		render :layout => false
  		end
	end

	def new
	    if request.headers['X-PJAX']
	      render :layout => false
	    end
	end

	def create
		
		# TODO: Qualatative and Quantatative.
	    question = @current_category.questions.create(
	                                qual: true,
	                                quant: true,
	                                text: params[:question][:text],
	                                impact: params[:impact].strip)
	    # Create responses somehow for collaborators?
	    
	end

	def destroy 
		
    	Question.destroy(get_current_question.id)
		
	end

	def update
		get_current_question.update_attributes!(text: params[:question][:text])
		
	end

	def comment
		
		comment = @current_question.comments.create(text: params[:comment][:text], user_id: current_user.id)
		

		

	end

end
