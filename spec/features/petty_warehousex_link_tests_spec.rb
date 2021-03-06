require 'spec_helper'

describe "LinkTests" do
  describe "GET /petty_warehousex_link_tests" do
    mini_btn = 'btn btn-mini '
    ActionView::CompiledTemplates::BUTTONS_CLS =
        {'default' => 'btn',
         'mini-default' => mini_btn + 'btn',
         'action'       => 'btn btn-primary',
         'mini-action'  => mini_btn + 'btn btn-primary',
         'info'         => 'btn btn-info',
         'mini-info'    => mini_btn + 'btn btn-info',
         'success'      => 'btn btn-success',
         'mini-success' => mini_btn + 'btn btn-success',
         'warning'      => 'btn btn-warning',
         'mini-warning' => mini_btn + 'btn btn-warning',
         'danger'       => 'btn btn-danger',
         'mini-danger'  => mini_btn + 'btn btn-danger',
         'inverse'      => 'btn btn-inverse',
         'mini-inverse' => mini_btn + 'btn btn-inverse',
         'link'         => 'btn btn-link',
         'mini-link'    => mini_btn +  'btn btn-link'
        }
    before(:each) do
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      
      ua1 = FactoryGirl.create(:user_access, :action => 'index', :resource => 'petty_warehousex_items', :role_definition_id => @role.id, :rank => 1,
      :sql_code => "PettyWarehousex::Item.order('created_at DESC')")
      ua1 = FactoryGirl.create(:user_access, :action => 'create', :resource => 'petty_warehousex_items', :role_definition_id => @role.id, :rank => 1,
      :sql_code => "")
      ua1 = FactoryGirl.create(:user_access, :action => 'update', :resource => 'petty_warehousex_items', :role_definition_id => @role.id, :rank => 1,
      :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'petty_warehousex_items', :role_definition_id => @role.id, :rank => 1,
      :sql_code => "record.received_by_id == session[:user_id]")
      user_access = FactoryGirl.create(:user_access, :action => 'create_warehouse_item', :resource => 'commonx_logs', :role_definition_id => @role.id, :rank => 1,
      :sql_code => "")
      
      a = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'piece_unit', :argument_value => 'piece, set, kg')
      @supplier = FactoryGirl.create(:supplierx_supplier)
      b = FactoryGirl.create(:commonx_misc_definition, :for_which => 'wh_item_category', :active => true)
      b = FactoryGirl.create(:commonx_misc_definition, :for_which => 'warehouse', :active => true)
      
      visit '/'
      #save_and_open_page
      fill_in "login", :with => @u.login
      fill_in "password", :with => @u.password
      click_button 'Login'
    end
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      q = FactoryGirl.create(:petty_warehousex_item, :supplier_id => @supplier.id, :received_by_id => @u.id)
      log = FactoryGirl.create(:commonx_log, :resource_id => q.id, :resource_name => 'petty_warehousex_items')
      
      visit items_path
      #save_and_open_page
      page.should have_content('Warehouse Items')
      click_link 'Edit'
      page.should have_content('Edit Warehouse Item')
      #save_and_open_page
      visit items_path
      click_link q.id.to_s
      #save_and_open_page
      page.should have_content('Warehouse Item Info')
      click_link 'New Log'
      page.should have_content('Log')
      
      visit new_item_path
      #save_and_open_page
      page.should have_content('New Warehouse Item')
    end
  end
end
