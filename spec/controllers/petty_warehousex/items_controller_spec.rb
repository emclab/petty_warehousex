require 'spec_helper'

module PettyWarehousex
  describe ItemsController do
  
    before(:each) do
      controller.should_receive(:require_signin)
      controller.should_receive(:require_employee)
      
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
    end
    
    render_views
    
    describe "GET 'index'" do
      it "returns all items" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource =>'petty_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "PettyWarehousex::Item.order('created_at DESC')")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.create(:petty_warehousex_item, :supplier_id => @supplier.id, :received_by_id => @u.id)
        q1 = FactoryGirl.create(:petty_warehousex_item, :supplier_id => @supplier.id, :received_by_id => @u.id)
        get 'index', {:use_route => :petty_warehousex}
        assigns(:items).should =~ [q, q1]
      end
      
    end
  
    describe "GET 'new'" do
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'petty_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        get 'new', {:use_route => :petty_warehousex, :supplier_id => @supplier.id}
        response.should be_success
      end
    end
  
    describe "GET 'create'" do
      it "returns redirect with success" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'petty_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.attributes_for(:petty_warehousex_item, :supplier_id => @supplier.id, :in_qty => 10, :unit_price => nil)
        get 'create', {:use_route => :petty_warehousex, :supplier_id => @supplier.id, :item => q}
        response.should redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
        assigns(:item).in_qty.should eq(10)
        assigns(:item).stock_qty.should eq(10)
      end
      
      it "should render new with data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'petty_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.attributes_for(:petty_warehousex_item, :supplier_id => @supplier.id, :name => nil)
        get 'create', {:use_route => :petty_warehousex, :supplier_id => @supplier.id, :item => q}
        response.should render_template('new')
      end
    end
  
    describe "GET 'edit'" do
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'petty_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.create(:petty_warehousex_item, :supplier_id => @supplier.id, :received_by_id => @u.id)
        get 'edit', {:use_route => :petty_warehousex, :id => q.id}
        response.should be_success
      end
    end
  
    describe "GET 'update'" do
      it "should redirect successfully" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'petty_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.create(:petty_warehousex_item, :supplier_id => @supplier.id, :received_by_id => @u.id)
        get 'update', {:use_route => :petty_warehousex, :id => q.id, :item => {:in_qty => 20}}
        response.should redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      end
      
      it "should render edit with data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'petty_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.create(:petty_warehousex_item, :supplier_id => @supplier.id, :received_by_id => @u.id)
        get 'update', {:use_route => :petty_warehousex, :id => q.id, :item => {:in_qty => 0}}
        response.should render_template('edit')
      end
    end
  
    describe "GET 'show'" do
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'petty_warehousex_items', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "record.received_by_id == session[:user_id]")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        q = FactoryGirl.create(:petty_warehousex_item, :supplier_id => @supplier.id, :received_by_id => @u.id)
        get 'show', {:use_route => :petty_warehousex, :id => q.id }
        response.should be_success
      end
    end
  end
end
