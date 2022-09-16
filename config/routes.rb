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
  scope module: :public do
  # Homesコントローラ
  get "/about" => "homes#about", as: "about"
  
  # Recruitsコントローラ
  # get "/recruits" => "recruits#index"
  # get "recruits/new" => "recruits#new"
  # post "/recruits" => "recruits#create", as: "create_recruits"
  # get "recruits/:id" => "recruits#show", as: "show_recruits"
  # get "recruits/:id/edit" => "recruits#edit", as: "edit_recruits"
  # patch "recruits/:id" => "recruits#update", as: "update_recruits"
  resources :recruits, :except => :destroy do
     # Likesコントローラ
    # post "recruit/likes" => "likes#create", as: "recruit_likes"
    # delete "recruit/likes" => "likes#destroy", as: "recruit_destroy_likes"
    resource :likes, :only => [:create, :destroy]
  end
    
  
  # Usersコントローラ
   get "users/my_page" => "users#my_page" , as: "my_page"
   get "users/:id/edit" => "users#edit", as: "edit_user"
   get "users/:id" => "users#show", as: "show_user"
   patch "users/:id" => "users#update", as: "update_user"
   get "users/unsubscribe" => "users#unsubscribe_confirm", as: "user_unsubscribe_confirm"
   patch "users/unsubscribe/:id" => "users#unsubscribe", as: "user_unsubscribe"
  
  # Entriesコントローラ
  # get "/entries" => "entries#index"
  # post "entries/:id" => "entries#create", as: "create_entries"
  # get "entries/:id" => "entries#show", as: "show_entries"
  # delete "entries/:id" => "entries#destroy", as: "destroy_entries"
  resources :entries, :only => [:index, :create, :show, :destroy]
  
  # Notifiesコントローラ
  # get "users/:user_id/notifies" => "notifies#index", as: "notifies"
  resources :notifies, :only => :index
  
  # Sitesコントローラ
  # get "/sites" => "sites#index"
  # post "/sites" => "sites#create", as: "create_sites"
  # delete "sites/:id" => "sites#destroy" , as: "destroy_sites"
  resources :sites, :only => [:index, :create, :destroy]
  
  # Messagesコントローラ
  # post "messages" => "messages#create", as: "create_messages"
  resources :messages, :only => :create
  
  # Roomsコントローラ
  # get "rooms/:id" => "room#show", as: "show_romms"
  # post "rooms" => "rooms#create"
  resources :rooms, :only => [:show, :create]
  
 
  end
  
  # 管理者画面のルーティング設定
  namespace :admin do
    # Homesコントローラ
    get "/" => "homes#top"
    
    # Genresコントローラ
    get "/genres" => "genres#index"
    post "/genres" => "genres#create"
    get "/genres/:id/edit" => "genres#edit", as: "edit_genres"
    patch "/genres/:id" =>"genres#update", as: "update_genres"
    
    # Uersコンロローラ
    get "users/:id" => "users#show", as: "show_users"
    get "users/:id/edit" => "users#edit", as: "edit_users"
    patch "users/:id" => "users#update", as: "update_users"
  end
end