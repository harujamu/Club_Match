class Public::NotifiesController < ApplicationController
  
  def index
    notifies = current_user.passive_notifications.where(checked_status: false)
    ids = notifies.pluck(:id)
    notifies.each do |notify|
      notify.update(checked_status: true)
    end
    @notifies = Notify.where(id: ids)
  end
  
  private
  
  def notify_params
    params.require(:notify).permit(:notifier_id, :checker_id, :like_id, :recruit_id, :entry_id, :message_id, :checked_status)
  end
  
end
