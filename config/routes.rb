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
  # ルートパス設定
  root to: "public/homes#top"
  
  # ユーザー画面のルーティング設定
  # Homesコントローラ
  get "/about" => "homes/about#about", as: "about"
  
  # Recruitsコントローラ
  get "/recruits" => "recruits#index"
  get "recruits/new" => "recruits#new"
  post "/recruits" => "recruits#create"
  get "recruits/:id" => "recruits#show"
  get "recruits/:id/edit" => "recruits#edit"
  patch "recruits/:id" => "recruits#update"
  
  # Usersコントローラ
  get "users/:id" => "users#show"
  get "users/:id/edit" => "users#edit"
  patch "users/:id" => "users#update"
  get "users/unsubscribe" => "users#unsubscribe_confirm"
  patch "users/unsubscribe/:id" => "users#unsubscribe"
  
  # Entriesコントローラ
  get "/entries" => "entries#index"
  get "entries/:id" => "entries#show"
  
  # Notifiesコントローラ
  get "users/:user_id/notifies" => "notifies#index"
  
  # Sitesコントローラ
  get "/sites" => "sites#index"
  post "/sites" => "sites"
  delete "sites/:id" => "sites#destroy"  
  
  # Messagesコントローラ
  post "messages" => "messages#create"
  
  # Roomsコントローラ
  get "rooms/:id" => "room#show"
  post "rooms" => "rooms#create"
  
  # 管理者画面のルーティング設定
  namespace :admin do
    # Homesコントローラ
    get "/admin" => "homes#top"
    
    # Genresコントローラ
    get "admin/genres" => "genres#index"
    post "admin/genres" => "genres#create"
    get "admin/genres/:id/edit"
    patch "admin/genres/:id" =>"genres#update"
    
    # Uersコンロローラ
    get "users/:id" => "users#show"
    get "users/:id/edit" => "users#edit"
    patch "users/:id" => "users#update"
    
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
