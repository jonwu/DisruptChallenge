class EvaluationController < ApplicationController
  respond_to :html, :js
  before_action :authenticate_user!

  def load_rfi_evaluation
  	@current_rfi = Rfi.find_by_id(params[:rfi_id])
		
		# Check if RFI is from current user
		if @current_rfi.user_id == current_user.id 
			set_current_rfi(@current_rfi)
			@categories = get_categories
			# defaults when first loading
      @active_category = set_active_category(get_categories.first)
			set_collaborators(get_current_rfi.collaborators)
			render :index
		else
			not_found
		end
  end

	def index
	end

	def toggle_category
		p "*" * 80
    @active_category = set_active_category(Category.find_by_id(params[:category]))
    redirect_to action: 'evaluation_page_update'
  end

  def update_active_question
  	@active_question = set_active_question(Question.find_by_id(params[:question]))
  	# update current_submissions
  	@current_submissions = set_current_submissions(Submission.find_submissions_from_collaborators(get_active_question, get_collaborators))
  	p @current_submissions
  	redirect_to action: 'evaluation_page_update'
  end

  def evaluation_page_update
    @categories = get_categories
    @active_category = get_active_category
    @active_question = get_active_question
    @current_submissions = get_current_submissions
    # @questions = set_questions(@active_category.questions.all)
    # @responses = set_responses(Response.get_rfi_responses(@questions, current_user.id))
    # @is_active = get_active_question
  end

	private
    $rfi
    $active_category
    $active_question
    $collaborators
    $current_submissions

    def set_current_rfi(rfi)
      $rfi = rfi
    end

    def get_current_rfi
      return $rfi
    end

    def set_collaborators(collaborators)
      $collaborators = collaborators
    end

    def get_collaborators
      return $collaborators
    end

    def get_categories
    	if !$rfi.nil?
      	return $rfi.categories.all
      end
    end

    def set_active_category(active_category)
      $active_category = active_category
      return $active_category
    end

    def get_active_category
      return $active_category
    end

    def set_active_question(active_question)
      $active_question = active_question
      return $active_question
    end

    def get_active_question
      return $active_question
    end

    def set_current_submissions(current_submissions)
      $current_submissions = current_submissions
    end

    def get_current_submissions
      return $current_submissions
    end
end
