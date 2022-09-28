class Public::RoomsController < ApplicationController

  def create
    # DMのルーム作るのは募集者
    @room = Room.new(user_ids: params[:user_ids], user_id: current_user.id)
    @room.save
    redirect_to room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id])
    @message = Message.new
    @messages = Message.all
    @recruit = Recruit.find(params[:id])
    @site = Site.find(@recruit.site_id)
  end

  private

  def recruit_params
    params.require(:recruit).permit(:user_id, :site_id, :date, :title, :practice_type, :detail, :age_group, :recruit_status, :open_status)
  end

  def message_params
    params.require(:message).permit(:user_id, :room_id, :message)
  end

end
