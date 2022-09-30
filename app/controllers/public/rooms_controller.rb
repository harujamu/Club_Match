class Public::RoomsController < ApplicationController

  def create
    # DMのルーム作るのは募集者
    @room = Room.new(user_ids: params[:user_ids], user_id: current_user.id, recruit_id: params[:recruit_id])
    @room.save
    redirect_to room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id])
    @message = Message.new
    @messages = Message.all
  end

  private

  def recruit_params
    params.require(:recruit).permit(:user_id, :site_id, :date, :title, :practice_type, :detail, :age_group, :recruit_status, :open_status)
  end

  def message_params
    params.require(:message).permit(:user_id, :room_id, :message)
  end
  
  def room_params
    params.require(:room).permit(:user_id, :recruit_id)
  end

end
