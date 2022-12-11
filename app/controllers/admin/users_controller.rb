# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  before_action :admin_only

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_user_path(@user.id)
  end


  private
    def user_params
      params.require(:user).permit(
        :club_name,
        :captain_last_name,
        :captain_first_name,
        :age_group,
        :genre_id,
        :prefecture,
        :municipality,
        :address,
        :introduction,
        :email,
        :active_status
      )
    end
end
