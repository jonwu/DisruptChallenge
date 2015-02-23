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
	end

	def index
	end

	def new
	end

	def create
		
		# TODO: Qualatative and Quantatative.
	    question = Question.create( category_id: params[:category_id],
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

end
