class ApplicationController < ActionController::Base
  # before_action :authenticate_user!, except: [:top]
  # before_action :authenticate_admin!, except: [:index]
  # before_action :configure_permitted_parameters,if: :devise_controller?
  before_action :authenticate_user_or_admin!, if: :admin_index
  before_action :configure_permitted_parameters,if: :devise_controller?

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Admin)
      admin_path
    else
      my_page_path
    end
  end


  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path
    else
      root_path
    end
  end

protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys:[:club_name, :captain_last_name, :captain_first_name, :prefecture, :municipality, :address, :age_group, :genre_id])
  end

  # ユーザーか管理者でログインしていないときはroot_pathに返す
  def authenticate_user_or_admin!
    if user_signed_in? || admin_signed_in?
    else
      redirect_to root_path
    end
  end

  # ログインしていなくても動かしたいもの（falseの時）
  def admin_index
    # ログイン画面
    if controller_name == 'sessions'
      return false
    # elsif controller_name == 'genres' && action_name == 'index'
      # return false
    # 新規登録画面
    elsif controller_name == 'registrations'
      return false
    # トップ画面
    elsif controller_name == 'homes' && action_name == 'top'
      return false
    # 新規登録の処理
    elsif controller_name == 'registrations' && action_name == 'create'
      return false
    # ゲストログイン
    elsif controller_name == 'sessions' && action_name == 'guest_sign_in'
      return false
    else
      return true
    end
  end

end
