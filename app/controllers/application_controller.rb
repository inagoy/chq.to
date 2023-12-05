class ApplicationController < ActionController::Base
  before_action :configuer_permitted_parameters, if: :devise_controller?

  protected
  def configuer_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :first_name, :last_name])
  end

  def after_sign_in_path_for(resource)
    links_path
  end
end
