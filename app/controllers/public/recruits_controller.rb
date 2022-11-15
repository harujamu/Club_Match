class Public::RecruitsController < ApplicationController
  before_action:recruit_change_limit, {only: [:edit, :update]}
  before_action:recruit_show_limit, {only: [:show]}

  def new
    user = current_user
    @recruit = Recruit.new
    @recruit.user_id = user.id
    @genre = Genre.find(user.genre_id)
    @sites = user.sites
  end

  def create
    @recruit = Recruit.new(recruit_params)
    user = current_user
    @recruit.user_id = user.id
    if @recruit.save
      redirect_to root_path
    else
      @genre = Genre.find(user.genre_id)
      @sites = user.sites
      render action: :new
    end
  end

  def show
    @recruit = Recruit.find(params[:id])
    @user = User.find(@recruit.user_id)
    @entry = Entry.find_by(user_id: current_user.id, recruit_id: @recruit.id) || Entry.new
    @entry.user_id = current_user.id
    @entries = @recruit.entries
  end

  def edit
    user = current_user
    @sites = user.sites
    @recruit = Recruit.find(params[:id])
    @genre = Genre.find(user.genre_id)
  end

  def update
    user = current_user
    @recruit = Recruit.find(params[:id])
      if @recruit.update(recruit_params)
        if @recruit.open_status == false
          @entries = @recruit.entries.where(entry_status: "entered")
          @entries.each do |entry|
            entry.update(entry_status: "match_rejected")
            @recruit.create_notification_match_rejected(current_user, entry)
          end
        end
        redirect_to recruit_path(@recruit.id)
      else
        @genre = Genre.find(user.genre_id)
        @sites = user.sites
        render action: :edit
      end
  end

  def update_status
    user = current_user
    @recruit = Recruit.find(params[:recruit_id])
      if @recruit.update(recruit_status_params)
        if @recruit.open_status == false
          @entries = @recruit.entries.where(entry_status: "entered")
          @entries.each do |entry|
            entry.update(entry_status: "match_rejected")
            @recruit.create_notification_match_rejected(current_user, entry)
          end
        end
        redirect_to recruit_path(@recruit.id)
      else
        @genre = Genre.find(user.genre_id)
        @sites = user.sites
        render action: :edit
      end
  end

  def index
    @recruits = current_user.recruits
  end

  def destroy
    recruit = Recruit.find(params[:id])
    if current_user == recruit.user
      recruit.destroy
      redirect_to my_page_path(current_user.id)
    else
    end
  end

  private

  def recruit_change_limit
    recruit = Recruit.find_by(id: params[:id])
    if !recruit || !(recruit.user_id == current_user.id)
      redirect_to root_path
    end
  end

  def recruit_show_limit
    recruit = Recruit.find_by(id: params[:id])
    # 募集が存在しない、募集作成者でない　または　参加者でない人は非公開記事を見れない
    if !recruit
      redirect_to root_path
    elsif recruit.open_status == false
      unless recruit.entries.find_by(user_id: current_user.id, entry_status: [:match, :done]) || recruit.user_id == current_user.id
          redirect_to root_path
      end
    end
  end

  def recruit_params
    params.require(:recruit).permit(:site_id, :date, :title, :practice_type, :detail, :age_group, :recruit_status, :open_status)
  end

  def recruit_status_params
    params.require(:recruit).permit(:recruit_status, :open_status)
  end

  def entry_params
    params.require(:entry).permit(:user_id, :recruit_id, :entry_status)
  end

  def user_params
    params.require(:user).permit(:club_name, :captain_last_name, :captain_first_name, :age_group, :genre_id, :prefecture, :municipality, :address, :introduction, :image, :email)
  end

  def site_params
    params.require(:site).permit(:prefecture, :municipality, :address, :user_id)
  end

  def room_params
    params.require(:room).permit(:user_id, :recruit_id, :user_ids)
  end


end
