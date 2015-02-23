class QuestionsController < BaseController	
	respond_to :html, :js

	def show
		authenticate_question(params[:id])
		initialize_template
		# if request.headers['X-PJAX']
		#     render :layout => false
	 	#  	end
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
		# TODO: Qualatative and Quantatative.
    question = Question.create( category_id: params[:category_id],
                                qual: true,
                                quant: true,
                                text: params[:question][:text],
                                impact: params[:impact].strip)
    # Create responses somehow for collaborators?
    initialize_template
    redirect_to question_path(id: question.id)
	end

	def destroy 
		authenticate_question(params[:id])
    Question.destroy(get_current_question.id)
		initialize_template
	end

	def update
		authenticate_question(params[:id])
		get_current_question.update_attributes!(text: params[:question][:text])
		initialize_template
	end

end
