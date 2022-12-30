# frozen_string_literal: true

module ApplicationHelper
  
  # ユーザープロフィール画像のリンク表示メソッド
  def profile_image(user, genre, width = 100, height = 100)
    # width, height で自由にサイズ調整できるようにした（width=100の部分で初期値設定）
    
    #ユーザー画像登録済み
    if user.image.attached?
      
      # ユーザー画像がcurrent_user本人の画像
      if user == current_user
        # マイページへリンク（登録画像表示）
        link_to user_my_page_path(user.id), class: "text-dark" do
          image_tag user.image,
          size: "#{width}x#{height}",
          class: "rounded-circle"
        end
        
      # 他人の画像に対する操作
      else
        # ユーザー詳細画面にリンク（登録画像表示）
        link_to user_path(user.id), class: "text-dark" do
          image_tag user.image,
          size: "#{width}x#{height}",
          class: "rounded-circle"
        end
      end
    
    # ユーザー画像未登録
    else
    
      # ユーザー画像がcurrent_user本人の画像
      if user == current_user
        # マイページへリンク（ユーザージャンル画像表示）
        link_to user_my_page_path(user.id), class: "text-dark" do
          image_tag genre.genre_image,
          size: "#{width}x#{height}",
          class: "rounded-circle"
        end
      
      # 他人の画像に対する操作
      else
        # ユーザー詳細画面にリンク（ユーザージャンル画像表示）
        link_to user_path(user.id), class: "text-dark" do
          image_tag genre.genre_image,
          size: "#{width}x#{height}",
          class: "rounded-circle"
        end
      end
      
    end
  end


  # チャット画面の作成・遷移メソッド
  def room_link(room, recruit)
    
    # Roomがすでにある場合
    if room.present?
      
      # チャット画面に遷移
      link_to room_path(recruit.room.id), class: "text-dark" do
        tag.i class: "far fa-comments text-dark"
      end
    
    # Roomがない場合
    else
      
      # current_userが応募者
      if recruit.user == current_user
        # 募集者と応募者たちのチャットグループを作成
        # RoomはRecruit IDさえあれば作れるので引数はRecruit IDだけ渡す
        link_to rooms_path(room, params: {
          recruit_id: recruit.id,
          user_id: current_user.id
        }),
        class: "text-dark",
        method: :post do
          tag.i class: " far fa-comments text-dark"
        end
      end
    end
    
  end


  # いいねのON／OFFメソッド
  def like_button(current_user, recruit)
    
    #投稿がいいねされている時 
    if recruit.liked_by?(current_user)
      #いいね削除 
      link_to recruit_likes_path(recruit), method: :delete do
        tag.i class: "fas fa-heart like-icon"
      end
    # まだいいねされていない時
    else
      # いいね作成
      link_to recruit_likes_path(recruit), method: :post do
        tag.i class: "far fa-heart like-icon"
      end
    end
  end

  # フォローのON／OFFメソッド
  ## user(user_id)はcurrent_user(follower_id)にフォローされているかでボタン表示変更
  def follow_button(user, current_user)
    
    # current_userが既にフォローしている時
    if user.followed_by?(current_user)
      # フォロー削除
      link_to user_follows_path(user), method: :delete do
        tag.i class: "fas fa-user-check follow-icon ml-2"
      end
    
    # current_userがフォローしていない時
    else
      # フォロー作成
      link_to user_follows_path(user), method: :post do
        tag.i class: "fas fa-user-plus ml-2 follow-icon"
      end
    end
    
  end

  # 練習形式の表示メソッド
  def practice_type(recruit)
    
    # 練習試合の時
    if recruit.practice_game?
      "練習試合"
      
    # 合同練習の時
    elsif recruit.joint_practice?
      "合同練習"
    end
    
  end

  # 公開非公開の表示メソッド
  def open_status(recruit)
    
    # 公開ステータスがtrueの時
    if recruit.open_status == true
      tag.p "公開中", 
      class: "green"
    
    # 公開ステータスがfalseの時
    else
      tag.p "公開停止中", 
      class: "gray"
    end
    
  end

  # ユーザーの活動ステータス表示メソッド
  def active_status(user)
    
    # アクティブステータスがtrueの時
    if user.active_status == true
      tag.p "活動中", 
      class: "green"
      
    # アクティブステータスがfalseの時
    else
      tag.p "退会済", 
      class: "gray"
    end
    
  end
  
  
end
