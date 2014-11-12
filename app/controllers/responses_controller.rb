class ResponsesController < ApplicationController
  respond_to :html, :js
  before_action :authenticate_user!
  
  def load_rfi_response
    @rfi = Rfi.find_by_id(params[:rfi_id]) or not_found
    @collaborator_ids = @rfi.collaborators.all.pluck(:user_id)
    @is_active = set_active_question(nil)


    if @collaborator_ids.include?(current_user.id)
      set_rfi(@rfi)
      # @questions = get_current_rfi.questions
      # @responses = Response.get_rfi_responses(@questions, current_user.id)
      @categories = get_categories
      @active_category = set_active_category(get_categories.first)
      @questions = set_questions(@active_category.questions.all)
      @responses = set_responses(Response.get_rfi_responses(@questions, current_user.id))
      render :index
    else
      # unauthorized access
      not_found
    end
  end

  def update_active_category_response
    @active_category = set_active_category(Category.find_by_id(params[:category]))
    redirect_to action: 'response_page_update'
  end

  def response_page_update
    @categories = get_categories
    @active_category = get_active_category
    @questions = set_questions(@active_category.questions.all)
    @responses = set_responses(Response.get_rfi_responses(@questions, current_user.id))
    @is_active = get_active_question
    p "*"*80
    p @is_active
  end

  def index
    
  end
  def edit_content
    @prev_question_id = params[:prev_question_id]
    @question_id = params[:question_id]
    @is_active = Question.find_by(id: @question_id)
    set_active_question(@is_active)
  end

  def save_content
    question_id = params[:question_id]
    text = params[:text]
    @responses = get_responses

    # Assume @responses comes from current user
    response = @responses.find_by_question_id(question_id)
    
    if response.nil?
      Response.create(question_id: question_id, user_id: current_user.id, text: text)
    else
      response.update(text:text)
    end
    render :nothing => true
  end


  private
    $rfi
    $questions
    $responses
    $active_category
    $active_question

    def set_active_question(active_question)
      $active_question = active_question
      return $active_question
    end

    def get_active_question
      return $active_question
    end
    def set_active_category(active_category)
      $active_category = active_category
      return $active_category
    end

    def get_active_category
      return $active_category
    end

    def get_categories
      return $rfi.categories.all
    end

    def set_rfi(rfi)
      $rfi = rfi
    end

    def get_current_rfi
      return $rfi
      # return current_user.rfis.first
    end

    def set_questions(questions)
      $questions = questions
    end

    def get_questions
      return $questions
    end

    def set_responses(responses)
      $responses = responses
      return responses
    end

    def get_responses
      return $responses
    end

end
