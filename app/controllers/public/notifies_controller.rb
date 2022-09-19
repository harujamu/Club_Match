class Public::NotifiesController < ApplicationController
  
  def index
    @notifies = current_user.passive_notifications
    @unchecked_notifies = @notifies.where(checked_status: false)
    @unchecked_notifies.each do |notify|
      notify.update_attributes(checked_status: true)
    end
  end
  
end
