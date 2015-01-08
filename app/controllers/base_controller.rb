class BaseController < ActionController::Base
	
  before_action :authenticate_user!
  before_filter :reset_values, :only => :show
  before_filter :authenticate_shared, :only => :show
	before_filter :authenticate_rfi, :only => :show
	before_filter :authenticate_category, :only => :show
	before_filter :authenticate_question, :only => :show
	before_filter :initialize_template, :only => :show

  def reset_values
    
    set_rfis(nil)
    set_shared(nil)
    set_current_rfi(nil)
    set_current_category (nil)
    set_current_question(nil)
    set_current_collaborator(nil)
  end

  def authenticate_shared

    if params[:shared] == true
      set_rfis(Rfi.shared(current_user))
      set_shared(true)
    else
      set_rfis(current_user.rfis)
      set_shared(false)
    end
  end

  def authenticate_rfi
    
    current_rfi = get_rfis.find_by(id: params[:rfi_id])
  	if current_rfi.nil?
  		# if user does not have permission, proceed with first rfi
  		return redirect_to rfi_path(rfi_id: get_rfis.first)
  	end
  	set_current_rfi(current_rfi) 
  end

  def authenticate_category 
  	if get_current_rfi.nil?
  		return set_current_category(nil)
  	end

  	current_category = get_current_rfi.categories.find_by_id(params[:category_id])
  	if current_category.nil?
  		# Redirect to previous rfi if category is invalid
  		return redirect_to rfi_path(rfi_id: get_current_rfi.id)
  	end
  	set_current_category(current_category)
  end


  def authenticate_question
  	if get_current_category.nil?
  		return set_current_question(nil)
  	end
  	
  	current_question = get_current_category.questions.find_by_id(params[:question_id])
  	if current_question.nil?
  		# Redirect to previous category if question is invalid
  		return redirect_to category_path(category_id: get_current_category.id)
  	end
  	set_current_question(current_question)
  end

  def initialize_template
    @rfis = get_rfis
    @shared = get_shared
    @current_rfi = get_current_rfi
    @current_category = get_current_category 
    @current_question = get_current_question
    
  end

  def initialize_content
    # should only be called if question is selected
    @current_collaborator = get_current_collaborator
  end

  protected
    $rfis
    $shared
    $current_rfi
    $current_category
    $current_question
    $current_collaborator

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
end
