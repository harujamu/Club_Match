Rails.application.routes.draw do
  
  # 管理者ログイン画面
  devise_for :admin,skip:[:passwords, :registrations], controllers:{
    sessions: "admin/sessions"
  }
  # ユーザーログイン・新規登録画面
  devise_for :users,skip:[:passwords], controllers:{
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  # ユーザー画面のルーティング設定
  
  
  # 管理者画面のルーティング設定
  namespace :admin do
    
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
