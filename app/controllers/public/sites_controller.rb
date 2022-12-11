# frozen_string_literal: true

class Public::SitesController < ApplicationController
  def create
    @site = Site.new(site_params)
    if @site.save
      redirect_to sites_path
    else
      render :index
    end
  end

  def index
    @site = Site.new
    @sites = current_user.sites
  end

  def destroy
    @site = Site.find(params[:id])
    @site.destroy
    redirect_to sites_path
  end

  private
    def site_params
      params.require(:site).permit(
        :prefecture,
        :municipality,
        :address,
        :user_id
      )
    end
end
