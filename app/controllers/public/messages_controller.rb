class Public::MessagesController < ApplicationController
  
  def create
    @message = Message.new(message_params)
    @message.save
    @room = Room.find( @message.room.id)
    @recruit = Recruit.find(@message.room.recruit.id)
    @recruit.create_nortification_message(current_user, @message)
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
