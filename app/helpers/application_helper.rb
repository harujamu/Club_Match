module ApplicationHelper

  # ユーザー画像があるときは画像表示、ないときはジャンルに紐づいた画像を表示する

  def profile_image(user, genre, width=100, height=100)
    # width, height で自由にサイズ調整できるようにした（width=100の部分で初期値設定）
    if user.image.attached?
      # "#{width}x#{height}のxはスペース開けない！
      if user == current_user
        link_to my_page_path(user.id), class:"text-dark" do
          image_tag user.image, size: "#{width}x#{height}", class:"rounded-circle"
        end
      else
        link_to show_user_path(user.id), class:"text-dark" do
          image_tag user.image, size: "#{width}x#{height}", class:"rounded-circle"
        end
      end
    else
      if user == current_user
        link_to my_page_path(user.id), class:"text-dark" do
          # tag.i class: "far fa-smile fa-#{n}x"
          image_tag genre.genre_image, size: "#{width}x#{height}", class:"rounded-circle"
        end
      else
        link_to show_user_path(user.id), class:"text-dark" do
          # tag.i class: "far fa-smile fa-#{n}x"
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
        link_to rooms_path(room, params: { recruit_id: recruit.id }), class:"text-dark", method: :post do
          tag.i class: " far fa-comments text-dark"
        end
      end
    end
  end

  # いいねのON／OFF
  def like_button(current_user, recruit)
    if recruit.liked_by?(current_user)
      link_to recruit_likes_path(recruit),class:"text-dark", method: :delete do
        tag.i class: "fas fa-heart", style: "color: FF6388;"
      end
    else
      link_to recruit_likes_path(recruit),class:"text-dark", method: :post do
        tag.i class: "far fa-heart", style: "color: FF6388;"
      end
    end
  end
  
  # 練習形式の表示
  def practice_type(recruit)
    if recruit.practice_game?
      return '練習試合'
    elsif recruit.joint_practice? 
      return '合同練習'
    end
  end
  
  # クラブ年齢層と募集年齢層の変換
  def age_group_number
    if current_user.age_group == "elementary_shool_student"
      return 2
    elsif current_user.age_group == "secondary_school_student"
      return 3
    elsif current_user.age_group == "high_school_student"
      return 4
    elsif current_user.age_group == "college_student"
      return 5
    else
      return 6
    end
  end
end

