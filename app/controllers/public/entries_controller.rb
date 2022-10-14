class Public::EntriesController < ApplicationController

  def create
    @entry = Entry.new(entry_params)
    @recruit = Recruit.find(@entry.recruit_id)
    @entry.save
    # 応募ステータスが応募済になったら、募集ステータスも候補者ありに更新+募集者に応募通知作成
    if @entry.entry_status == "entered"
      @recruit.update(recruit_status: "having_candidates")
      @recruit.create_notification_entry(current_user, @entry)
    end

    # recruit_status = recruiting ?
    redirect_to recruit_path(@recruit.id)
  end

  def destroy
    @entry = Entry.find(params[:id])
    @recruit = @entry.recruit
    @entry.destroy
    if @recruit.entries.nil?
      @recruit.update(recruit_status: "recruiting")
    end
    redirect_to root_path
  end

  def index
    @user = current_user
    @entries = @user.entries

  end

  def update
    @entry = Entry.find(params[:id])
    @recruit = Recruit.find(@entry.recruit_id)
    @entry.update(entry_params)

    # 応募ステータスがマッチ不成立になったら応募者に不成立通知作成
    if @entry.entry_status == "match_rejected"
      @recruit.create_notification_match_rejected(current_user, @entry)
      redirect_to recruit_path(@recruit.id)

    # 応募ステータスがマッチになったら、応募者にマッチ通知作成
    elsif @entry.entry_status == "match"
      @recruit.create_notification_match(current_user, @entry)
      redirect_to recruit_path(@recruit.id)
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:user_id, :recruit_id, :entry_status)
  end

  def recruit_params
    params.require(:recruit).permit(:user_id, :site_id, :date, :title, :practice_game, :joint_practice, :detail, :age_group, :recruit_status, :open_status)
  end

  def room_params
    params.require(:room).permit(:user_id, :recruit_id)
  end

end
