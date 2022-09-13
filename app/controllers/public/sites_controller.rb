class Public::SitesController < ApplicationController
  
  def create
    @site = Site.new(site_params)
    @site.save
    redirect_to sites_path
  end
  
  def index
    @site = Site.new
    @sites = Site.all
  end
  
  def destroy
    @site = Site.find(params[:id])
  end
  
  private
  
  def site_params
    params.require(:site).permit(:prefecture, :municipality, :address, :id, :user_id)
  end
  
end
