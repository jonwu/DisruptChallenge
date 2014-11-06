class ResponsesController < ApplicationController
  respond_to :html, :js
  before_action :authenticate_user!
  
  def load_rfi_response
    p "*"*80
    @rfi = Rfi.find_by_id(params[:rfi_id]) or not_found
    @collaborator_ids = @rfi.collaborators.all.pluck(:user_id)
    if @collaborator_ids.include?(current_user.id)
      set_rfi(@rfi)
      @questions = get_current_rfi.questions
      @responses = Response.get_rfi_responses(@questions, current_user.id)
      set_responses(@responses)
      render :index
    else
      # unauthorized access
      not_found
    end
  end

  def index
  end

  private
    $rfi
    $responses

    def set_rfi(rfi)
      $rfi = rfi
    end

    def get_current_rfi
      return $rfi
      # return current_user.rfis.first
    end

    def set_responses(responses)
      $responses = responses
    end

    def get_responses
      return $responses
    end

end
