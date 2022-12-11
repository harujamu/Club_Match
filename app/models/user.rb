# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum age_group: {
    elementary_shool_student: 1,
    secondary_school_student: 2,
    high_school_student: 3,
    college_student: 4,
    adult: 5

  }
  enum prefecture: {
    hokkaido: 1,
    aomori: 2,
    iwate: 3,
    miyagi: 4,
    akita: 5,
    yamagata: 6,
    hukushima: 7,
    ibaraki: 8,
    tochigi: 9,
    gunma: 10,
    saitama: 11,
    chiba: 12,
    tokyo: 13,
    kanagawa: 14,
    niigata: 15,
    toyama: 16,
    ishikawa: 17,
    fukui: 18,
    yamanashi: 19,
    nagano: 20,
    gifu: 21,
    shizuoka: 22,
    aichi: 23,
    mie: 24,
    shiga: 25,
    kyoto: 26,
    osaka: 27,
    hyogo: 28,
    nara: 29,
    wakayama: 30,
    tottori: 31,
    shimane: 32,
    okayama: 33,
    hiroshima: 34,
    yamaguchi: 35,
    okushima: 36,
    kagawa: 37,
    ehime: 38,
    kochi: 39,
    fukuoka: 40,
    saga: 41,
    nagasaki: 42,
    oita: 43,
    kumamoto: 44,
    miiyazaki: 45,
    kagoshima: 46,
    okinawa: 47
  }


  has_many :rooms, through: :user_room
  has_many :user_rooms
  has_many :messages
  has_many :active_notifications, class_name: "Notify", foreign_key: "notifier_id"
  has_many :passive_notifications, class_name: "Notify", foreign_key: "checker_id"
  has_many :entries
  belongs_to :genre
  has_many :sites
  has_many :recruits
  has_many :likes
  has_many :follows
  has_one_attached :image

  def captain_name
    captain_last_name + " " + captain_first_name
  end

  def user_address
    prefecture_i18n + " " + municipality + " " + address
  end

  # user（follower_idに代入）にフォローされているかどうか調べる
  def followed_by?(user)
    follows.exists?(follower_id: user.id)
  end

  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.password =
      SecureRandom.alphanumeric(10)
      + [*"a".."z"].sample(1).join + [*"0".."9"].sample(1).join
      user.club_name = "ゲストユーザー"
      user.captain_first_name = "Match"
      user.captain_last_name = "Club"
      user.prefecture = 1
      user.municipality = "Sample City"
      user.address = "Sample Address"
      user.age_group = 1
      user.genre_id = 1
    end
  end

  # フォロー通知メソッド
  def create_notification_follow(current_user, follow)
    # フォローされてるか調べる
    temp = Notify.where([
      "notifier_id = ? and
      checker_id = ? and
      action = ? and
      follow_id = ? and
      checked_status = ?",
      current_user.id,
      id,
      "follow",
      follow.id,
      false
    ])
    # フォローされてなければ通知レコード作成
    if temp.blank?
      notify = current_user.active_notifications.new(
        checker_id: id,
        follow_id: follow.id,
        action: "follow"
      )
      # 自分へのフォローは通知済とする
      if notify.notifier_id == notify.checker_id
        notify.checked_status = true
      end
      notify.save if notify.valid?
    end
  end


  validates :club_name, uniqueness: true, presence: true
  validates :captain_first_name, presence: true
  validates :captain_last_name, presence: true
  validates :introduction, allow_blank: true, length: { maximum: 300 }
  validates :age_group, presence: true
  validates :email, uniqueness: true, presence: true
  validates :prefecture, presence: true
  validates :municipality, presence: true
  validates :address, uniqueness: true, presence: true
end
