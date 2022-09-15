class Public::SitesController < ApplicationController
  
  def create
    @site = Site.new(site_params)
    @site.user_id = current_user.id
    @site.save
    redirect_to sites_path
  end
  
  def index
    @site = Site.new
    @site.user_id = current_user.id
    @sites = current_user.sites
  end
  
  def destroy
    @site = Site.find(params[:id])
    @site.destroy
    redirect_to sites_path
  end
  
  private
  
  def site_params
    params.require(:site).permit(:prefecture, :municipality, :address, :user_id)
  end
  
end
