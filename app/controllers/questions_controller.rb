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

	def create
		authenticate_category(params[:category_id])
		p params
		# TODO: Qualatative and Quantatative.
    question = Question.create( category_id: params[:category_id],
                                qual: true,
                                quant: true,
                                text: params[:question][:text],
                                impact: params[:impact].strip)
    # Create responses somehow for collaborators?
    initialize_template
	end

end
