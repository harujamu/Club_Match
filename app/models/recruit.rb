class Recruit < ApplicationRecord
  enum age_group:{ unspecified: 1, elementary_shool_student: 2, secondary_school_student: 3, high_school_student: 4, college_student: 5, adult: 6 }
  enum recruit_status:{ recruiting: 1, having_candidates: 2, match: 3, done: 4 }
  enum practice_type:{ practice_game: 1, joint_practice: 2 }

  after_find do |recruit|
    # 募集記事の練習日超えた場合の処理
    if recruit.match? && (recruit.date.before? Date.today)
      recruit.entries.update(entry_status: "done")
      recruit.update(open_status: false,recruit_status: "done")
    elsif (recruit.recruiting? || recruit.having_candidates?) && (recruit.date.before? Date.today)
      recruit.update(open_status: false)
    end
    
    # 退会ユーザーの募集記事を非公開にする
    if recruit.user.active_status == false
      recruit.update(open_status: false)
    end
   
    # 非公開になったら応募中の応募者にマッチ不成立を通知
    if recruit.open_status == false
      entries = recruit.entries.where(entry_status: "entered")
      entries.each do |entry|
        entry.update(entry_status: "match_rejected")
        recruit.create_notification_match_rejected(current_user, entry)
      end
    end
    # 募集記事の応募者がいない時の処理
    if recruit.entries.empty?
      recruit.update(recruit_status: "recruiting")
    end

  end



  belongs_to :user
  belongs_to :site
  has_many :likes, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :notifies, dependent: :destroy
  has_one :room

  validates :date, presence: true
  validates :title, presence: true
  validates :practice_type, presence: true
  validates :detail, allow_blank: true, length: { maximum: 300 }
  validates :age_group, presence: true

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  def create_notification_like(current_user, like)
    # いいねされてるか調べる
    temp = Notify.where(["notifier_id = ? and checker_id = ? and recruit_id = ? and action = ? and like_id = ? and checked_status = ?", current_user.id, user_id, id, 'like', like.id, false])
    # いいねされてなければ通知レコード作成
    if temp.blank?
      notify = current_user.active_notifications.new(
        recruit_id: id,
        checker_id: user_id,
        like_id: like.id,
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
    end
  end

  def create_notification_message(current_user, message)
    # ユーザー複数の場合はeachで！！！
    # each分の中でreturnは使わない、次に行くならnext

    #usersはmessage.room.usersのうち、currentuserでないuserのみ抽出した
    users = message.room.users.select {|user| user != current_user }
    users.each do |user|
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

