class Public::MessagesController < ApplicationController
  
  def create
    @message = Message.new(message_params)
    @message.save
    redirect_to room_path(@message.room_id)
  end
  
  private
  
  def message_params
    params.require(:message).permit(:user_id, :room_id, :message)
  end
  
  def room_params
    params.require(:room).permit(:user_id)
  end
  
end
