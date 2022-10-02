module ApplicationHelper
  
  # ユーザー画像があるときは画像表示、ないときはアイコン表示する
  
  def user_image(user, width=100, height=100, n)
    # width, height で自由にサイズ調整できるようにした（width=100の部分で初期値設定）
    if user.image.attached?
      # "#{width}x#{height}のxはスペース開けない！
      image_tag user.image, size: "#{width}x#{height}", class:"rounded-circle"
    else
      tag.i class: "far fa-smile fa-#{n}x"
    end
  end
  
  # トーク画面の作成・遷移
  
  def room_link(room, recruit)
    if room.blank?
      # 募集者と応募者たちのチャットグループを作成、RoomはRecruit IDさえあれば作れるので引数はRecruit IDだけ渡す
        link_to rooms_path(room, params: { recruit_id: recruit.id }), class:"text-dark", method: :post do 
          tag.i class: "far fa-comment text-dark"
        end
    else
      # Roomがすでにある場合はチャット画面に遷移
        link_to room_path(recruit.id), class:"text-dark" do
          tag.i class: "far fa-comment text-dark"
        end
    end
  end
  
  
  
  
end

