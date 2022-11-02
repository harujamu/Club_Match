class Public::RoomsController < ApplicationController
  before_action :room_member_only, on: :show

  def create
    # チャットルーム作るのは募集者（user_id）、募集IDはRoom作成時に持たせたID
    recruit = Recruit.find(params[:recruit_id])
    @room = Room.new(user_id: current_user.id, recruit_id: params[:recruit_id]) || Room.find_by(recruit_id: recruit.id)

    #tチャットルームのメンバーは、募集に対する応募者で、応募ステータスがマッチの人のみ
    user_ids = recruit.entries.where(entry_status: "match").pluck(:user_id)

    # 応募者たちのユーザーIDをそれぞれ抽出し、User_Roomにカラム追加していく
    user_ids.each do |user_id|
      @room.user_rooms.build(user_id: user_id)
    end
    # チャットルーム作成者もUser_Roomにカラム追加していく
    @room.user_rooms.build(user_id: @room.user.id)
    if @room.save
      redirect_to room_path(@room.id)
    end
  end

  def show
    @room = Room.find(params[:id])
    @recruit = Recruit.find(@room.recruit.id)
    @message = Message.new
    @messages = Message.where(room_id: @room.id)
    @users = @room.users
  end

  private
  
  def room_member_only
    room = Room.find_by(id: params[:id])
    if !room || !room.user_rooms.find_by(user_id: current_user.id)
      redirect_to root_path
    end
  end

  def recruit_params
    params.require(:recruit).permit(:user_id, :site_id, :date, :title, :practice_type, :detail, :age_group, :recruit_status, :open_status)
  end

  def message_params
    params.require(:message).permit(:user_id, :room_id, :message)
  end

  def room_params
    params.require(:room).permit(:user_id, :recruit_id, :user_ids)
  end

end
