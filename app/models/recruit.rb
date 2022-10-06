class Recruit < ApplicationRecord
  enum age_group:{ unspecified: 0, junior_school_student: 1, secondary_school_student: 2, high_school_student: 3, college_student: 4, adult: 5 }
  enum recruit_status:{ recruiting: 0, having_candidates: 1, match: 2, decline: 3, done:4 }

  belongs_to :user
  belongs_to :site
  has_many :likes, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :notifies, dependent: :destroy
  has_one :room

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  def create_notification_like(current_user)　
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


  def create_notification_entry(current_user,entry)
    # 応募ステータスが”応募済”か調べる
    temp = Notify.where(["notifier_id = ? and checker_id = ? and recruit_id = ? and entry_id = ? and action = ? and checked_status = ?", current_user.id, user_id, id, entry.id, 'entry', false])
    #応募済なら通知レコード作成
    if temp.blank?
      notify = current_user.active_notifications.new(
        recruit_id: id,
        checker_id: user_id,
        entry_id: entry.id,
        action: 'entry'
      )
      notify.save if notify.valid?
    end
  end

  def create_notification_match(current_user,entry)
    # 応募ステータスが"マッチ"か調べる
    temp = Notify.where(["notifier_id = ? and checker_id = ? and recruit_id = ? and entry_id = ? and action = ? and checked_status = ?", current_user.id, user_id, id, entry.id, 'match', false ])
    # マッチなら通知レコード作成
    if temp.blank?
      # current_user（= notifier_id）は通知送る人（募集者）
      notify = current_user.active_notifications.new(
        recruit_id: id,
        # checkerは通知受ける人(応募者)
        checker_id: entry.user_id,
        entry_id: entry.id,
        action: 'match'
      )
      notify.save if notify.valid?
    end
  end

  def create_notification_cancel(current_user,entry)
    # 応募ステータスが"キャンセル"か調べる
    temp = Notify.where(["notifier_id = ? and checker_id = ? and recruit_id = ? and entry_id = ? and action = ? and checked_status = ?", current_user.id, user_id, id, entry.id, 'cancel', false ])
    # キャンセルなら通知レコード作成
    if temp.blank?
      notify = current_user.active_notifications.new(
        recruit_id: id,
        checker_id: entry.user_id,
        entry_id: entry.id,
        action: 'cancel'
      )
      notify.save if notify.valid?
    end
  end

  def create_notification_match_rejected(current_user,entry)
    # 応募ステータスが"マッチ不成立"か調べる
    temp = Notify.where(["notifier_id = ? and checker_id = ? and recruit_id = ? and entry_id = ? and action = ? and checked_status = ?", current_user.id, user_id, id, entry.id, 'match_rejected', false ])
    # マッチ不成立なら通知レコード作成
    if temp.blank?
      notify = current_user.active_notifications.new(
        recruit_id: id,
        checker_id: entry.user_id,
        entry_id: entry.id,
        action: 'match_rejected'
      )
      notify.save if notify.valid?
      # temp.destroy
    end
  end

  def create_notification_message(current_user, message)
    # ユーザー複数の場合はeachで！！！
    message.room.users.each do |user|
      return if user.id == current_user.id
      # メッセージがあるか調べる
      temp = Notify.where(["notifier_id = ? and checker_id = ? and recruit_id = ?  and message_id = ? and action = ? and checked_status = ?",current_user.id, user.id, id, message.id, 'message', false ])
      # メッセージなければ通知作成
      if temp.blank?
        notify = current_user.active_notifications.new(
          recruit_id: id,
          checker_id: user.id,
          message_id: message.id,
          action: 'message'
        )
        
        # 自分のコメントは通知済とする
        if notify.notifier_id == notify.checker_id
          notify.checked_status = true
        end
        notify.save if notify.valid?
      end
    end
  end


end

