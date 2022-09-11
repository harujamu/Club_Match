class ApplicationController < ActionController::Base
   before_action :configure_permitted_parameters,
  if: :devise_controller?
protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys:[:club_name, :captain_last_name, :captain_first_name, :prefecture, :municipality, :address, :age_group, :genre_id])
  end
end
