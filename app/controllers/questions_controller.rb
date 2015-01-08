class QuestionsController < BaseController
	layout 'main_template'
	respond_to :html, :js
	
	def show
		

	end

	def questions
		@path = question_path
		current_question = get_current_category.questions.find_by_id(params[:question_id])
		set_current_question(current_question)
		initialize_template
	end
end
