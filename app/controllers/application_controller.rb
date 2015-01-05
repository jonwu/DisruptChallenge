  class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_main_template

  rescue_from ActionView::MissingTemplate do |exception|
    redirect_to dashboard_index_path
    # use exception.path to extract the path information
    # This does not work for partials
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')

  end

  def redirect_home
    redirect_to dashboard_index_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  
  def set_main_template
    @current_rfi = set_current_rfi(current_user.rfis.first)
    @current_category = set_current_category(@current_rfi.categories.first)
    @current_question = set_current_question(nil)
  end

  protected
    $current_rfi
    $current_category
    $current_question

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


    def set_current_page(current_page)
      $current_page = current_page
    end

    def get_current_page
      return $current_page
    end
end
