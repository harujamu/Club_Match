module ApplicationHelper

  # ユーザー画像があるときは画像表示、ないときはジャンルに紐づいた画像を表示する

  def user_image(user, genre, width=100, height=100)
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
    if room.id.present?
      link_to room_path(room.id), class:"text-dark" do
        tag.i class: "far fa-comments text-dark"
      end
    else
      # 募集者と応募者たちのチャットグループを作成、RoomはRecruit IDさえあれば作れるので引数はRecruit IDだけ渡す
      link_to rooms_path(room, params: { recruit_id: recruit.id }), class:"text-dark", method: :post do
        tag.i class: " far fa-comments text-dark"
      end
    end
  end

  # いいねのON／OFF
  def liked_status(current_user, recruit)
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

end

