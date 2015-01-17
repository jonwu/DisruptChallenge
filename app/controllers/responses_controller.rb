class ResponsesController < BaseController

  respond_to :html, :js

  def show
    authenticate_response(params[:id])
    initialize_template
  end

  def index
    authenticate_category(params[:category_id])
    initialize_template
  end

  def authenticate_response(question_id)
    authenticate_question(question_id)
    current_response = Response.get_user_response(question_id, current_user.id)
    set_current_response(current_response)
  end

  def save_response
    text = params[:text]
    if !text.nil?
      question_id = get_current_question.id
      Response.update_text(question_id,text,current_user)
    end
  end

end

  # respond_to :html, :js
  # before_action :authenticate_user!
  
  # def show
  #   current_rfi = Rfi.find_by_id(params[:id])
  #   if !current_rfi.nil?
  #     current_collaborator = current_rfi.collaborators.find_by(user_id: current_user.id)
  #     if !current_collaborator.nil?
  #       set_current_collaborator(current_collaborator)
  #       set_current_rfi(current_rfi)
  #       @is_active = set_active_question(nil)
  #       @categories = get_categories
  #       @active_category = set_active_category(get_categories.first)
  #       @questions = set_questions(@active_category.questions.all)
  #       @responses = set_responses(Response.get_rfi_responses(@questions, current_user.id))
  #       @last_updated = Submission.get_last_updated(get_current_collaborator)
  #       return
  #     end
  #   end
  #   redirect_home
  # end

  # def update_active_category
  #   set_active_category(Category.find_by_id(params[:category]))
  #   redirect_to responses_page_update_path
  # end

  # def page_update
  #   @categories = get_categories
  #   @active_category = get_active_category
  #   @questions = set_questions(@active_category.questions.all)
  #   @responses = set_responses(Response.get_rfi_responses(@questions, current_user.id))
  #   @is_active = get_active_question
  #   @last_updated = Submission.get_last_updated(get_current_collaborator)
  # end

  # def index
  # end

  # def collapse_content
  #   text = params[:text]
  #   if !text.nil?
  #     question_id = get_active_question.id
  #     update_text(question_id,text)
  #   end
    
  #   if !get_active_question.nil?
  #     # so text editor doesn't show for ANY question
  #     set_active_question(nil)
  #     redirect_to responses_page_update_path
  #   else
  #     render :nothing => true
  #   end
    
  # end

  # def edit_content
  #   # this is never used.
  #   @prev_question_id = params[:prev_question_id]
  #   @question_id = params[:question_id]
  #   @is_active = Question.find_by(id: @question_id)
  #   set_active_question(@is_active)
  # end

  # def save_content
  #   question_id = params[:question_id]
  #   text = params[:text]
  #   update_text(question_id,text)
  #   redirect_to responses_page_update_path
  # end

  # def submit
  #   all_responses = Response.get_all_rfi_responses(get_categories, current_user.id)
  #   collaborator = get_current_collaborator
  #   hasSubmitted = false

  #   if Submission.exists?(collaborator_id: collaborator.id)
  #     hasSubmitted = true
  #   end
    
  #   for response in all_responses
  #     text = response.text
  #     submission = Submission.create_with(text: '').find_or_create_by(collaborator_id: collaborator.id, response_id: response.id, question_id: response.question.id)
  #     if submission.text != text
  #       submission.create_activity :update, recipient: get_current_rfi.user, owner: current_user
  #       submission.update(text: text)
  #     end
  #   end

  #   if !hasSubmitted
  #     submission.create_activity :submit, recipient: get_current_rfi.user, owner: current_user
  #   end
  #   redirect_to responses_page_update_path
  # end


  # private
  #   $rfi
  #   $questions
  #   # responses under only a certain category!
  #   # For all responses, use Response.get_all_rfi_responses
  #   $responses
  #   $active_category
  #   $active_question
  #   $current_collaborator
  #   $last_updated

  #   def update_text(question_id, text)
  #     # Assume get_responses comes from current user
  #     response = get_responses.find_by_question_id(question_id)
  #     if (!response.nil?)
  #       response.update(text:text)
  #     end
  #   end


  #   def set_current_last_updated(last_updated)
  #     $last_updated = last_updated
  #     return $last_updated
  #   end

  #   def get_current_last_updated
  #     return $last_updated
  #   end

  #   def set_current_collaborator(collaborator)
  #     $collaborator = collaborator
  #     return $collaborator
  #   end

  #   def get_current_collaborator
  #     return $collaborator
  #   end

  #   def set_active_question(active_question)
  #     $active_question = active_question
  #     return $active_question
  #   end

  #   def get_active_question
  #     return $active_question
  #   end

  #   def set_active_category(active_category)
  #     $active_category = active_category
  #     return $active_category
  #   end

  #   def get_active_category
  #     return $active_category
  #   end

  #   def get_categories
  #     return $rfi.categories.all
  #   end

  #   def set_current_rfi(rfi)
  #     $rfi = rfi
  #   end

  #   def get_current_rfi
  #     return $rfi
  #   end

  #   def set_questions(questions)
  #     $questions = questions
  #   end

  #   def get_questions
  #     return $questions
  #   end

  #   def set_responses(responses)
  #     $responses = responses
  #     return responses
  #   end

  #   def get_responses
  #     return $responses
  #   end

# end
