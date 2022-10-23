class Public::RecruitsController < ApplicationController

  def new
    @user = current_user
    @recruit = Recruit.new
    @recruit.user_id = @user.id
    @genre = Genre.find(@user.genre_id)
    @sites = @user.sites
  end

  def create
    @recruit = Recruit.new(recruit_params)
    @user = current_user
    @recruit.user_id = @user.id
    if @recruit.save
      redirect_to root_path
    else
      render :new
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
    @user = current_user
    @sites = @user.sites
    @recruit = Recruit.find(params[:id])
    @genre = Genre.find(@user.genre_id)
  end

  def update
    @user = current_user
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
        render :edit
      end
  end

  def index
    @user = current_user
    @recruits = @user.recruits
    # @recruits.each do |recruit|
    # # @room = Room.find_by(recruit_id: recruit.id) || Room.new

    #   if recruit.match? && (recruit.date.before? Date.today)
    #     recruit.update(open_status: false, recruit_status: "done")
    #     recruit.entries.update(entry_status: "done")
    #   elsif (recruit.recruiting? || recruit.having_candidates?) && (recruit.date.before? Date.today)
    #     recruit.update(open_status: false)
    #   elsif @user.active_status == false
    #     recruit.update(open_status: false)
    #   end
    # end
  end

  private

  def recruit_params
    params.require(:recruit).permit(:user_id, :site_id, :date, :title, :practice_type, :detail, :age_group, :recruit_status, :open_status)
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
