module ApplicationHelper

  # ユーザー画像があるときは画像表示、ないときはジャンルに紐づいた画像を表示する
  def profile_image(user, genre, width=100, height=100)
    # width, height で自由にサイズ調整できるようにした（width=100の部分で初期値設定）
    if user.image.attached?
      # "#{width}x#{height}のxはスペース開けない！
      if user == current_user
        link_to user_my_page_path(user.id), class:"text-dark" do
          image_tag user.image, size: "#{width}x#{height}", class:"rounded-circle"
        end
      else
        link_to user_path(user.id), class:"text-dark" do
          image_tag user.image, size: "#{width}x#{height}", class:"rounded-circle"
        end
      end
    else
      if user == current_user
        link_to user_my_page_path(user.id), class:"text-dark" do
          image_tag genre.genre_image, size: "#{width}x#{height}", class:"rounded-circle"
        end
      else
        link_to user_path(user.id), class:"text-dark" do
          image_tag genre.genre_image, size: "#{width}x#{height}", class:"rounded-circle"
        end
      end
    end
  end

  # トーク画面の作成・遷移
  def room_link(room, recruit)
    # Roomがすでにある場合はチャット画面に遷移
    if room.present?
      link_to room_path(recruit.room.id), class:"text-dark" do
        tag.i class: "far fa-comments text-dark"
      end
    else
      if recruit.user == current_user
        # 募集者と応募者たちのチャットグループを作成、RoomはRecruit IDさえあれば作れるので引数はRecruit IDだけ渡す
        link_to room_path(room, params: { recruit_id: recruit.id }), class:"text-dark", method: :post do
          tag.i class: " far fa-comments text-dark"
        end
      end
    end
  end

  # いいねのON／OFF
  def like_button(current_user, recruit)
    if recruit.liked_by?(current_user)
      link_to recruit_likes_path(recruit), method: :delete do
        tag.i class: "fas fa-heart like_icon"
      end
    else
      link_to recruit_likes_path(recruit), method: :post do
        tag.i class: "far fa-heart like_icon"
      end
    end
  end

  # フォローのON／OFF
  # user(user_id)はcurrent_user(follower_id)にフォローされているかでボタン表示変更
  def follow_button(user, current_user)
    if user.followed_by?(current_user)
      link_to user_follows_path(user), method: :delete do
        tag.i class: "fas fa-user-check follow-icon ml-2"
      end
    else
      link_to user_follows_path(user), method: :post do
        tag.i class: "fas fa-user-plus ml-2 follow-icon"
      end
    end
  end

  # 練習形式の表示
  def practice_type(recruit)
    if recruit.practice_game?
      "練習試合"
    elsif recruit.joint_practice?
      "合同練習"
    end
  end

  # 公開非公開の表示
  def open_status(recruit)
    if recruit.open_status == true
      "公開中"
    else
      "公開停止中"
    end
  end

  # ユーザーの活動ステータス
  def active_status(user)
    if user.active_status == true
      "活動中"
    else
      "退会済"
    end
  end

end

