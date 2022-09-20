class Public::NotifiesController < ApplicationController
  
  def index
    @notifies = current_user.passive_notifications
    @notifies.where(checked_status: false).each do |notify|
      notify.update(checked_status: true)
    end
  end
  
  private
  
  def notify_params
    params.require(:notify).permit(:notifier_id, :checker_id, :like_id, :recruit_id, :entry_id, :message_id, :checked_status)
  end
  
end
