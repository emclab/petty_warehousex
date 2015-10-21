require 'rails_helper'

module PettyWarehousex
  RSpec.describe ItemsController, type: :controller do
    routes {PettyWarehousex::Engine.routes}
    before(:each) do
      expect(controller).to receive(:require_signin)
      expect(controller).to receive(:require_employee)
      
    end
    
    before(:each) do
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      a = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'piece_unit', :argument_value => 'piece, set, kg')
      @supplier = FactoryGirl.create(:supplierx_supplier)
      b = FactoryGirl.create(:commonx_misc_definition, :for_which => 'wh_item_category', :active => true)
      b = FactoryGirl.create(:commonx_misc_definition, :for_which => 'warehouse', :active => true)
      
      session[:user_role_ids] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id).user_role_ids
    end
    
    render_views
    
    describe "GET 'index'" do
      it "returns all items" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'petty_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "PettyWarehousex::Item.order('created_at DESC')")
        session[:user_id] = @u.id
        q = FactoryGirl.create(:petty_warehousex_item, :supplier_id => @supplier.id, :received_by_id => @u.id)
        q1 = FactoryGirl.create(:petty_warehousex_item, :supplier_id => @supplier.id, :received_by_id => @u.id)
        get 'index'
        expect(assigns(:items)).to match_array([q, q1])
      end
      
      it "should return with the part name" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'petty_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "PettyWarehousex::Item.order('created_at DESC')")
        session[:user_id] = @u.id
        q = FactoryGirl.create(:petty_warehousex_item, name: 'a bad guy', :supplier_id => @supplier.id, :received_by_id => @u.id)
        q1 = FactoryGirl.create(:petty_warehousex_item, :supplier_id => @supplier.id, :received_by_id => @u.id)
        get 'index', {part_name: 'a bad guy'}
        expect(assigns(:items)).to match_array([q])
      end

      it "should return with the part num" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'petty_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "PettyWarehousex::Item.order('created_at DESC')")
        session[:user_id] = @u.id
        q = FactoryGirl.create(:petty_warehousex_item, name: 'a bad guy', :supplier_id => @supplier.id, :received_by_id => @u.id)
        q1 = FactoryGirl.create(:petty_warehousex_item, :supplier_id => @supplier.id, :received_by_id => @u.id, part_num: '123456')
        get 'index', {part_num: '123456'}
        expect(assigns(:items)).to match_array([q1])
      end

      it "should return with the part spec" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'petty_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "PettyWarehousex::Item.order('created_at DESC')")
        session[:user_id] = @u.id
        q = FactoryGirl.create(:petty_warehousex_item, name: 'a bad guy', :supplier_id => @supplier.id, :received_by_id => @u.id, spec: '2TB')
        q1 = FactoryGirl.create(:petty_warehousex_item, :supplier_id => @supplier.id, :received_by_id => @u.id)
        get 'index', {part_spec: '2TB'}
        expect(assigns(:items)).to match_array([q])
      end
      
    end
  
    describe "GET 'new'" do
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'petty_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        get 'new', {:supplier_id => @supplier.id}
        expect(response).to be_success
      end
    end
  
    describe "GET 'create'" do
      it "returns redirect with success" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'petty_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        q = FactoryGirl.attributes_for(:petty_warehousex_item, :supplier_id => @supplier.id, :in_qty => 10, :unit_price => nil)
        get 'create', {:supplier_id => @supplier.id, :item => q}
        expect(response).to redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Successfully Saved!")
        expect(assigns(:item).in_qty).to eq(10)
        expect(assigns(:item).stock_qty).to eq(10)
      end
      
      it "should render new with data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'petty_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        q = FactoryGirl.attributes_for(:petty_warehousex_item, :supplier_id => @supplier.id, :name => nil)
        get 'create', {:supplier_id => @supplier.id, :item => q}
        expect(response).to render_template('new')
      end
    end
  
    describe "GET 'edit'" do
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'petty_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        q = FactoryGirl.create(:petty_warehousex_item, :supplier_id => @supplier.id, :received_by_id => @u.id)
        get 'edit', {:id => q.id}
        expect(response).to be_success
      end
    end
  
    describe "GET 'update'" do
      it "should redirect successfully" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'petty_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        q = FactoryGirl.create(:petty_warehousex_item, :supplier_id => @supplier.id, :received_by_id => @u.id)
        get 'update', {:id => q.id, :item => {:in_qty => 20}}
        expect(response).to redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Successfully Updated!")
      end
      
      it "should render edit with data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'petty_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        q = FactoryGirl.create(:petty_warehousex_item, :supplier_id => @supplier.id, :received_by_id => @u.id)
        get 'update', {:id => q.id, :item => {:in_qty => 0}}
        expect(response).to render_template('edit')
      end
    end
  
    describe "GET 'show'" do
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'petty_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "record.received_by_id == session[:user_id]")
        session[:user_id] = @u.id
        q = FactoryGirl.create(:petty_warehousex_item, :supplier_id => @supplier.id, :received_by_id => @u.id)
        get 'show', {:id => q.id }
        expect(response).to be_success
      end
    end
  end
end
