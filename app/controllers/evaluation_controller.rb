class EvaluationController < ApplicationController
  respond_to :html, :js
  before_action :authenticate_user!

  def load_rfi_evaluation
  	@current_rfi = Rfi.find_by_id(params[:rfi_id])
		# Check if RFI is from current user
		if @current_rfi != nil && @current_rfi.user_id == current_user.id 
			set_current_rfi(@current_rfi)
			@categories = get_categories
			# defaults when first loading
      @active_category = set_active_category(get_categories.first)
      @active_question = set_active_question(Question.find_by_id(@active_category.questions.first.id))
      @current_submissions = set_current_submissions(@current_rfi.submissions.where(question_id: get_active_question.id).all)
      if params.has_key?(:category_id)
        @active_category = set_active_category(@categories.find_by_id(params[:category_id]))
      end
      
      # find number of unrated submissions
			set_collaborators(get_current_rfi.collaborators)
      @num_unrated = Submission.get_number_unrated(get_categories, get_collaborators)
			render :index
		else
			redirect_to dashboard_index_path
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
    redirect_to action: 'evaluation_page_update'
  end

  def evaluation_page_update
    @categories = get_categories
    @active_category = get_active_category
    @active_question = get_active_question
    @current_submissions = get_current_submissions
    @num_unrated = Submission.get_number_unrated(get_categories, get_collaborators)
  end

  def save_rating
  	submission_id = params[:submission_id]
  	rating = params[:rating]
  	submission = Submission.find_by_id(submission_id)
  	submission.update(score: rating)
    redirect_to action: 'categories_page_update'
  end

  def categories_page_update
    @categories = get_categories
    @active_category = get_active_category
    @active_question = get_active_question
    # need to reset the current submissions to include updated score and then update page.
    @current_submissions = set_current_submissions(Submission.find_submissions_from_collaborators(get_active_question, get_collaborators))
    @num_unrated = Submission.get_number_unrated(get_categories, get_collaborators)
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
