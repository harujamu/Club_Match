# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :er_state, only: [:create]
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

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました'
  end
    
    
  
  protected
  
  def user_state
    @user = User.find_by(email: params[:user][:email], club_name: params[:user][:club_name], captain_last_name: params[:user][:captain_last_name], captain_first_name: prams[:user][:captain_first_name])
    return if !@user
    if @user.valid_password?(params[:user][:password]) && @user.active_status == false
      redirect_to new_user_registration_path and return
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
