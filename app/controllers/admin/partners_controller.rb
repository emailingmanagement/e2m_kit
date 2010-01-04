class Admin::PartnersController < ApplicationController
  before_filter :require_user, :get_kit
  before_filter :get_partner, :only => [:edit, :update, :destroy]
    
  def index
  end
  
  def new
    @partner = Partner.new
  end

  def create
    @partner = Partner.new(params[:partner].merge(:kit => @kit, :user => @current_user))
    render :new and return unless @partner.save
    flash[:notice] = t(:partners_partner_created_flash)
    redirect_to admin_kits_path
  end
  
  def edit
  end
  
  def update
    @partner.attributes = params[:partner]
    render :edit and return unless @partner.save
    flash[:notice] = t(:partners_partner_updated_flash)
    redirect_to admin_kits_path
  end
  
  def destroy
    flash[:notice] = t(:partners_partner_destroyed_flash) if @partner.destroy
    redirect_to admin_kits_path
  end
  
  private  
    def get_partner
      render_404 and return unless @partner = Partner.find_by_id(params[:id])
    end
end