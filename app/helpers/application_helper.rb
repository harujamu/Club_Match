module ApplicationHelper
  
  # ユーザー画像があるときは画像表示、ないときはアイコン表示する
    # width, height で自由にサイズ調整できるようにした（width=100の部分で初期値設定）
  def user_image(user, width=100, height=100)
    if user.image.attached?
      # "#{width}x#{height}のxはスペース開けない！
      image_tag user.image, size: "#{width}x#{height}"
    else
      tag.i class: "far fa-smile"
    end
  end
  
end
