class Public::MessagesController < ApplicationController
  
  def create
    @message = Message.new(message_params)
  end
  
  private
  
  def message_params
    params.require(:message).permit(:user_id, :room_id, :message)
  end
  
end
