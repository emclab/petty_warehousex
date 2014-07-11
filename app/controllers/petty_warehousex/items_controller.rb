require_dependency "petty_warehousex/application_controller"

module PettyWarehousex
  class ItemsController < ApplicationController
    before_filter :require_employee
    before_filter :load_record
    
    def index
      @title = t('Warehouse Items')
      @items = params[:petty_warehousex_items][:model_ar_r]
      @items = @items.where(whs_string: @whs_string) if @whs_string
      @items = @items.where(project_id: @project.id) if @project
      @items = @items.page(params[:page]).per_page(@max_pagination)
      @erb_code = find_config_const('item_index_view', 'petty_warehousex')
    end
  
    def new
      @title = t('New Warehouse Item')
      @item = PettyWarehousex::Item.new()
      @qty_unit = find_config_const('piece_unit').split(',').map(&:strip)
      @item_category = Commonx::CommonxHelper.return_misc_definitions('whs_item_category')
      @erb_code = find_config_const('item_new_view', 'petty_warehousex')
    end
  
    def create
      @item = PettyWarehousex::Item.new(params[:item], :as => :role_new)
      @item.last_updated_by_id = session[:user_id]
      @item.received_by_id = session[:user_id]
      @item.stock_qty = params[:item][:in_qty]
      if @item.save
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      else
        @whs_string = params[:item][:whs_string]
        @project = PettyWarehousex.project_class.find_by_id(params[:item][:project_id].to_i) if params[:item][:project_id].present?
        @item_category = return_misc_definitions('whs_item_category')
        @qty_unit = find_config_const('piece_unit').split(',').map(&:strip)
        @erb_code = find_config_const('item_new_view', 'petty_warehousex')
        flash[:notice] = t('Data Error. Not Saved!')
        render 'new'
      end
    end
  
    def edit
      @title = t('Update Warehouse Item')
      @item = PettyWarehousex::Item.find_by_id(params[:id])
      @qty_unit = find_config_const('piece_unit').split(',').map(&:strip)
      @item_category = Commonx::CommonxHelper.return_misc_definitions('wh_item_category')
      @erb_code = find_config_const('item_edit_view', 'petty_warehousex')
    end
  
    def update
      @item = PettyWarehousex::Item.find_by_id(params[:id])
      @item.last_updated_by_id = session[:user_id]
      if @item.update_attributes(params[:item], :as => :role_update)
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      else
        @qty_unit = find_config_const('piece_unit').split(',').map(&:strip)
        @item_category = Commonx::CommonxHelper.return_misc_definitions('wh_item_category')
        @erb_code = find_config_const('item_edit_view', 'petty_warehousex')
        flash[:notice] = t('Data Error. Not Updated!')
        render 'edit'
      end
    end
  
    def show
      @title = t('Warehouse Item Info')
      @item = PettyWarehousex::Item.find_by_id(params[:id])
      @erb_code = find_config_const('item_show_view', 'petty_warehousex')
    end
    
    protected
    def load_record
      @whs_string = params[:whs_string].strip if params[:whs_string].present?
      @project = PettyWarehousex.project_class.find_by_id(params[:project_id].to_i) if params[:project_id].present?
      item = PettyWarehousex::Item.find_by_id(params[:id]) if params[:id].present?
      @project = PettyWarehousex.project_class.find_by_id(item.project_id) if params[:id].present? && item.project_id.present?  #project_id optional
    end
  end
end
