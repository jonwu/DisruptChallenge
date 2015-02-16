class BaseController < ActionController::Base
	layout 'main_template'
  before_action :authenticate_user!
  before_filter :reset_values, :only => [:index, :show]

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def reset_values
    set_rfis(nil)
    set_shared(nil)
    set_current_rfi(nil)
    set_current_category (nil)
    set_current_question(nil)
    set_current_collaborator(nil)

    set_current_response(nil)
  end 


  def authenticate_rfi(rfi_id)
    current_rfi = Rfi.find_by_id(rfi_id) or not_found
    status = current_rfi.user == current_user or not_found
    set_current_rfi(current_rfi) 
    set_rfis(current_user.rfis)
  end


  def authenticate_question(question_id)
    current_question = Question.find_by_id(question_id) or not_found
    current_category = current_question.category or not_found
    authenticate_category(current_category.id)
    set_current_question(current_question)
  end

  def authenticate_category(category_id)
    current_category = Category.find_by_id(category_id) or not_found
    current_rfi = current_category.rfi
    authenticate_rfi(current_rfi.id)
    set_current_category(current_category)
  end

  def authenticate_collaborator(id)
    current_rfi = Rfi.find_by_id(id) or not_found
    rfis = Rfi.invited(current_user)
    rfis.find_by_id(current_rfi.id) or not_found
    set_current_rfi(current_rfi)
    set_rfis(rfis)
  end
 
  def initialize_template
    @rfis = get_rfis
    @shared = get_shared
    @current_rfi = get_current_rfi
    @current_category = get_current_category 
    @current_question = get_current_question
    @current_response = get_current_response
  end

  protected
    $rfis
    $shared
    $current_rfi
    $current_category
    $current_question
    $current_collaborator
    $current_response

    def set_rfis(rfis)
      $rfis = rfis
    end

    def get_rfis
      return $rfis
    end

    def set_shared(shared)
      $shared = shared
    end

    def get_shared
      return $shared
    end

    def set_current_rfi(current_rfi)
      $current_rfi = current_rfi
    end

    def get_current_rfi
      return $current_rfi
    end

    def set_current_question(current_question)
      $current_question = current_question
    end

    def get_current_question
      return $current_question
    end

    def set_current_category(current_category)
      $current_category = current_category
    end

    def get_current_category
      return $current_category
    end


    def set_current_collaborator(current_collaborator)
      $current_collaborator = current_collaborator
    end

    def get_current_collaborator
      return $current_collaborator
    end

    def set_current_submissions(current_submissions)
      $current_submissions = current_submissions
    end

    def get_current_submissions
      return $current_collaborator
    end

    def set_current_response(response)
      $current_response = response
    end

    def get_current_response
      return $current_response
    end
end
