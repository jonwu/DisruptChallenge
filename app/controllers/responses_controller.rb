class ResponsesController < ApplicationController
  def load_rfi_response
    @rfi = Rfi.find_by_id(params[:rfi_id])
    @collaborator_ids = @rfi.collaborators.all.pluck(:user_id)
    if @collaborator_ids.include?(current_user.id)
      set_rfi(@rfi)
      @questions = get_current_rfi.questions
      render :index
    else
      # unauthorized access
      redirect_to dashboard_index_path
      return
    end

  end

  def index
  end

  private
    $rfi

    def set_rfi(rfi)
      $rfi = rfi
    end

    def get_current_rfi
      return $rfi
      # return current_user.rfis.first
    end

end
