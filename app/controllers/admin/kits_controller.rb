class Admin::KitsController < ApplicationController
  before_filter :require_user
  before_filter :get_kit, :only => [:edit, :update, :destroy]
  
  def index
    @kits = Kit.all
  end
  
  def new
    @kit = Kit.new
  end
  
  def create
    @kit = Kit.new(params[:kit])
    @kit.user = @current_user
    render :new and return unless @kit.save
    1.upto(10) do |i|
      field = :"css_picture#{i}"
      next if params[field].blank?
      CssPicture.new(:picture => params[field], :kit => @kit).save!
    end    
    flash[:notice] = t(:kits_kit_created_flash)
    redirect_to admin_kits_path
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    @kit.attributes = params[:kit]
    render :edit and return unless @kit.save
    1.upto(10) do |i|
      field = :"css_picture#{i}"
      next if params[field].blank?
      @kit.css_pictures[i].destroy if @kit.css_pictures[i]
      CssPicture.new(:picture => params[field], :kit => @kit).save!
    end
    flash[:notice] = t(:kits_kit_updated_flash)
    redirect_to admin_kits_path
  end
  
  def destroy
    flash[:notice] = t(:kits_kit_destroyed_flash) if @kit.destroy
    redirect_to admin_kits_path
  end
  
  private
    def get_kit
      render_404 and return unless @kit = Kit.find_by_permalink(params[:id])
    end
end