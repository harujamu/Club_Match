class Public::MessagesController < ApplicationController
  
  def create
    @message = Message.new(message_params)
    @message.save
    @room = Room.find(params[:id])
    redirect_to room_path(@room.id)
  end
  
  private
  
  def message_params
    params.require(:message).permit(:user_id, :room_id, :message)
  end
  
end
