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
      Response.update_response_text(question_id, text, current_user.id)
    end
    render :nothing => true
  end

end