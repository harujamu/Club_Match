class Recruit < ApplicationRecord
  enum age_group:{ unspecified: 0, junior_school_student: 1, secondary_school_student: 2, high_school_student: 3, college_student: 4, adult: 5 }
  enum recruit_status:{ recruiting: 0, having_candidates: 1, match: 2, decline: 3, done:4 }
  
  belongs_to :user
  has_many :sites
  has_many :likes, dependent: :destroy
  has_many :entries
  has_many :notifies
  
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  def create_nortification_like(current_user)
    # いいねされてるか調べる
    temp = Notify.where(["notifier_id = ? and checker_id = ? and recruit_id = ? and action = ? and checked_status = ?", current_user.id, user_id, id, 'like', false])
    # いいねされてなければ通知レコード作成
    if temp.blank?
    notify = current_user.active_notifications.new(
      recruit_id: id,
      checker_id: user_id,
      action: 'like'
      )
      # 自分の投稿へのいいねは通知済とする
      if notify.notifier_id == notify.checker_id
        notify.checked_status = true
      end
      notify.save if notify.valid?
    end
  end
  
  
  def create_nortification_entry(current_user,entry)
    # ステータスが”応募済”か調べる
    temp = Notify.where(["notifier_id = ? and checker_id = ? and recruit_id = ? and entry_id = ? and action = ?", current_user.id, user_id, id, entry.id, 'entry'])
    #応募済なら通知レコード作成
    if temp.blank?
      notify = current_user.active_notifications.new(
      recruit_id: id,
      checker_id: user_id,
      action: 'entry'
      )
      
      notify.save if notify.valid?
    end
  end
  
  
end

