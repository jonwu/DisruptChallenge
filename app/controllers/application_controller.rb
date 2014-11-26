class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActionView::MissingTemplate do |exception|
    redirect_to dashboard_index_path
    # use exception.path to extract the path information
    # This does not work for partials
  end
  def not_found
    raise ActionController::RoutingError.new('Not Found')

  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end
end
