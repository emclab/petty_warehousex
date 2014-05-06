require_dependency "petty_warehousex/application_controller"

module PettyWarehousex
  class ItemsController < ApplicationController
    before_filter :require_employee
    before_filter :load_record
    
    def index
      @title = t('Warehouse Items')
      @items = params[:petty_warehousex_items][:model_ar_r]
      @items = @items.where(whs_string: @whs_string) if @whs_string
      @items = @items.where(project_id: @project_id) if @project_id
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
        @project_id = params[:item][:project_id]
        @item_category = return_misc_definitions('whs_item_category')
        @qty_unit = find_config_const('piece_unit').split(',').map(&:strip)
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
      @project_id = params[:project_id]
    end
  end
end
