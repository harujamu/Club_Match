# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :only_active_user!, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]
  # before_action はアクション動かす前
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: "ゲストユーザーとしてログインしました"
  end



  protected
    def only_active_user!
      user = User.find_by(email: params[:user][:email])
      redirect_to new_user_registration_path if user&.valid_password?(params[:user][:password]) && !user&.active_status
    end
end
