require 'rails_helper'

module PettyWarehousex
  RSpec.describe Item, type: :model do
    it "should be OK" do
      c = FactoryGirl.create(:petty_warehousex_item)
      expect(c).to be_valid
    end
    
    it "should take 0 qty & stock_qty" do
      c = FactoryGirl.build(:petty_warehousex_item, :in_qty => 0, :stock_qty => 0)
      expect(c).to be_valid
    end
    
    it "should reject 0 item_id" do
      c = FactoryGirl.build(:petty_warehousex_item, :item_id => 0)
      expect(c).not_to be_valid
    end
    
    it "should taek 0 total cost" do
      c = FactoryGirl.build(:petty_warehousex_item, :total_cost => 0)
      expect(c).to be_valid
    end
    
    it "should reject 0 item_category" do
      c = FactoryGirl.build(:petty_warehousex_item, :item_category_id => 0)
      expect(c).not_to be_valid
    end
    
    it "should take nil unit" do
      c = FactoryGirl.build(:petty_warehousex_item, :unit => nil)
      expect(c).to be_valid
    end
    
    it "should take nil i_unit_id" do
      c = FactoryGirl.build(:petty_warehousex_item, :unit_id => nil)
      expect(c).to be_valid
    end
    
    it "should reject nil in_date" do
      c = FactoryGirl.build(:petty_warehousex_item, :in_date => nil)
      expect(c).not_to be_valid
    end
    
    it "should take nil item_name" do
      c = FactoryGirl.build(:petty_warehousex_item, :name => nil)
      expect(c).to be_valid
    end
    
    it "should reject nil storage_location" do
      c = FactoryGirl.build(:petty_warehousex_item, :storage_location => nil)
      expect(c).not_to be_valid
    end
    
    it "should reject if stock_qty > in_qty" do
      c = FactoryGirl.build(:petty_warehousex_item, :in_qty => 1, :stock_qty => 2)
      expect(c).not_to be_valid
    end
    
    it "should be OK if stock_qty == in_qty" do
      c = FactoryGirl.build(:petty_warehousex_item, :in_qty => 1, :stock_qty => 1)
      expect(c).to be_valid
    end
    
    it "should reject nil stock_qty" do
      c = FactoryGirl.build(:petty_warehousex_item, :stock_qty => nil)
      expect(c).not_to be_valid
    end
  end
end
