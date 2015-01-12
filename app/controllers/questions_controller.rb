class QuestionsController < BaseController
	layout 'main_template'
	
	respond_to :html, :js

	def show
		authenticate_question(params[:id])
		initialize_template
	end

	def index
		authenticate_category(params[:category_id])
		initialize_template
	end
	def questions
		@path = question_path
		current_question = get_current_category.questions.find_by_id(params[:question_id])
		set_current_question(current_question)
		initialize_template
	end


end
