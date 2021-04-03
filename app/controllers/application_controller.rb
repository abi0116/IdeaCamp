class ApplicationController < ActionController::Base
  before_action :configure_permit_parameters, if: :devise_controller?
  
  protected
  
  def configure_permit_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys: [:last_name,:first_name,:postal_code,:address,:telephone_number])
    devise_parameter_sanitizer.permit(:sign_in,keys: [:last_name,:first_name])
  end
end
