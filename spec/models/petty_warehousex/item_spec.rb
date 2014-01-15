require 'spec_helper'

module PettyWarehousex
  describe Item do
    it "should be OK" do
      c = FactoryGirl.create(:petty_warehousex_item)
      c.should be_valid
    end
    
    it "should reject 0 qty" do
      c = FactoryGirl.build(:petty_warehousex_item, :in_qty => 0)
      c.should_not be_valid
    end
    
    it "should reject 0 total cost" do
      c = FactoryGirl.build(:petty_warehousex_item, :total_cost => 0)
      c.should_not be_valid
    end
    
    it "should reject nil warehouse id" do
      c = FactoryGirl.build(:petty_warehousex_item, :warehouse_id => nil)
      c.should_not be_valid
    end
    
    it "should reject 0 item_category" do
      c = FactoryGirl.build(:petty_warehousex_item, :item_category_id => 0)
      c.should_not be_valid
    end
    
    it "should reject nil unit" do
      c = FactoryGirl.build(:petty_warehousex_item, :unit => nil)
      c.should_not be_valid
    end
    
    it "should reject nil in_date" do
      c = FactoryGirl.build(:petty_warehousex_item, :in_date => nil)
      c.should_not be_valid
    end
    
    it "should reject nil item_name" do
      c = FactoryGirl.build(:petty_warehousex_item, :name => nil)
      c.should_not be_valid
    end
    
    it "should reject nil spec" do
      c = FactoryGirl.build(:petty_warehousex_item, :spec => nil)
      c.should_not be_valid
    end
    
    it "should reject nil storage_location" do
      c = FactoryGirl.build(:petty_warehousex_item, :storage_location => nil)
      c.should_not be_valid
    end
    
    it "should reject if stock_qty > in_qty" do
      c = FactoryGirl.build(:petty_warehousex_item, :in_qty => 1, :stock_qty => 2)
      c.should_not be_valid
    end
    
    it "should be OK if stock_qty == in_qty" do
      c = FactoryGirl.build(:petty_warehousex_item, :in_qty => 1, :stock_qty => 1)
      c.should be_valid
    end
    
    it "should reject nil stock_qty" do
      c = FactoryGirl.build(:petty_warehousex_item, :stock_qty => nil)
      c.should_not be_valid
    end
  end
end
