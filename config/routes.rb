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
  
  # ゲストログイン
  devise_scope :user do
  post '/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
  
  # ユーザー画面のルーティング設定
  scope module: :public do
  # Homesコントローラ
  get "/about" => "homes#about", as: "about"
  
  # Recruitsコントローラ
  
  resources :recruits do
  # , :except => :destroy do
  patch "update_status" => "recruits#update_status", as: "update_status"
  # Likesコントローラ
    resource :likes, :only => [:create, :destroy]
  end
    
  # Usersコントローラ
   get "users/my_page" => "users#my_page" , as: "my_page"
   get "users/:id/edit" => "users#edit", as: "edit_user"
   get "users/:id" => "users#show", as: "show_user"
   patch "users/:id" => "users#update", as: "update_user"
   get "users/unsubscribe/:id" => "users#unsubscribe_confirm", as: "user_unsubscribe_confirm"
   patch "users/unsubscribe/:id" => "users#unsubscribe", as: "user_unsubscribe"
  
  # Entriesコントローラ
  resources :entries, :only => [:index, :create, :show, :destroy, :update]
  
  # Notifiesコントローラ
  resources :notifies, :only => :index
  
  # Sitesコントローラ
  resources :sites, :only => [:index, :create, :destroy]
  
  # Messagesコントローラ
  resources :messages, :only => :create
  
  # Roomsコントローラ
  resources :rooms, :only => [:show, :create]
  
 
  end
  
  # 管理者画面のルーティング設定
  namespace :admin do
    # Homesコントローラ
    get "/" => "homes#top"
    
    # Genresコントローラ
    # get "/genres" => "genres#index"
    # post "/genres" => "genres#create"
    # get "/genres/:id/edit" => "genres#edit", as: "edit_genres"
    # patch "/genres/:id" =>"genres#update", as: "update_genres"
    resources :genres, :only => [:index, :create, :edit, :update]
    
    # Uersコンロローラ
    # get "users/:id" => "users#show", as: "show_users"
    # get "users/:id/edit" => "users#edit", as: "edit_users"
    # patch "users/:id" => "users#update", as: "update_users"
    resources :users, :only => [:show, :edit, :update]
  end
end