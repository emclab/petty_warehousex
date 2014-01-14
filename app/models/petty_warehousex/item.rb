module PettyWarehousex
  class Item < ActiveRecord::Base
    attr_accessor :supplier_name, :received_by_name, :item_category_name, :warehouse_name
    attr_accessible :in_date, :in_qty, :item_category_id, :last_updated_by_id, :name, :note, :other_cost, :spec, :stock_qty, :storage_location, :supplier_id, 
                    :unit, :unit_price, :inspection, :warehouse_id,
                    :as => :role_new
    attr_accessible :in_date, :in_qty, :item_category_id, :last_updated_by_id, :name, :note, :other_cost, :spec, :stock_qty, :storage_location, :supplier_id, 
                    :unit, :unit_price, :inspection, :warehouse_id,
                    :supplier_name, :received_by_name, :item_category_name, :warehouse_name,
                    :as => :role_update
                    
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :received_by, :class_name => 'Authentify::User'
    belongs_to :item_category, :class_name => 'Commonx::MiscDefinition'
    belongs_to :warehouse, :class_name => 'Commonx::MiscDefinition'
    belongs_to :supplier, :class_name => PettyWarehousex.supplier_class.to_s

    validates :name, :spec, :unit, :storage_location, :in_date, :presence => true
    validates_numericality_of :in_qty, :item_category_id, :warehouse_id, :only_integer => true, :greater_than => 0
    validates_numericality_of :stock_qty, :less_than_or_equal_to => :in_qty
    validates :stock_qty, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  end
end
