class Public::RoomsController < ApplicationController

  def create
    # DMのルーム作るのは募集者（user_id）、募集IDはRoom作成時に持たせたID
    @room = Room.new(user_id: current_user.id, recruit_id: params[:recruit_id])
    recruit = Recruit.find(params[:recruit_id])

    #グループメンバー（応募者たち）は、募集に対する応募者で、応募ステータスがマッチの人のみ
    # .select(:user_id)はrecruit~"match")に当てはまるユーザーのIDのみ抽出してuser_idsに保存している
    user_ids = recruit.entries.where(entry_status: "match").pluck(:user_id)

    # 応募者たちのユーザーIDをそれぞれ抽出し、User_Roomにカラム追加していく
    user_ids.each do |user_id|
      @room.user_rooms.build(user_id: user_id)
    end
    @room.save!
    redirect_to room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id])
    @recruit = Recruit.find(@room.recruit.id)
    @message = Message.new
    @messages = Message.all

    @users = User.where(id: @room.user_rooms.pluck(:user_id))
  end

  private

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
