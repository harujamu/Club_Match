class Public::UsersController < ApplicationController

  def my_page
    @user = current_user
    @notifies = current_user.passive_notifications.where(checked_status: false)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    user = current_user
    if user.update(user_params)
      redirect_to my_page_path(user)
    else
      render :edit
    end
  end

  def unsubscribe_confirm
    @user = current_user
  end

  def unsubscribe
    @user = current_user
    if @user.recruits.where(recruit_status: "match").any? || @user.entries.where(entry_status: "match").any?
      flash[:alret] = "マッチ中の募集または応募があるため退会できませんでした"
      redirect_to user_unsubscribe_confirm_path(@user.id)
    else
      @user.update(active_status: false)
      reset_session
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:club_name, :captain_last_name, :captain_first_name, :age_group, :genre_id, :prefecture, :municipality, :address, :introduction, :image, :email, :active_status)
  end

  def genre_params
    params.require(:genre).permit(:name, :genre_image)
  end

end
