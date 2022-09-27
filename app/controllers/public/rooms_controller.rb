class Public::RoomsController < ApplicationController
  
  def create
    @room = Room.new(room_params)
    redirect_to room_path(@room.id)
  end
  
  def show
    @room = Room.find(params[:id])
    @messages = Message.all
  end
  
  private
  
  def room_params
    params.require(:room).permit(:user_id)
  end
  
  
end
