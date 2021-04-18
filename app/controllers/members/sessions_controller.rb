# frozen_string_literal: true

class Members::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  before_action :configure_permit_parameters, if: :devise_controller?

  protected

  def configure_permit_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys: [:last_name,:first_name,:postal_code,:address,:telephone_number,:email])
    #devise_parameter_sanitizer.permit(:sign_in,keys: [:last_name,:first_name])
  end
end
