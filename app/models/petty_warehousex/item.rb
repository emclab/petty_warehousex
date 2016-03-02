module PettyWarehousex
  class Item < ActiveRecord::Base
    attr_accessor :supplier_name, :received_by_name, :item_category_name, :warehouse_name, :project_name, :accepted_noupdate, :purchase_order_id_noupdate, 
                  :field_changed, :name_autocomplete, :item_sub_category_name

    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :item, :class_name => PettyWarehousex.material_item_class.to_s
    belongs_to :received_by, :class_name => 'Authentify::User'
    belongs_to :item_category, :class_name => PettyWarehousex.category_class.to_s
    belongs_to :item_sub_category, :class_name => PettyWarehousex.sub_category_class.to_s
    belongs_to :supplier, :class_name => PettyWarehousex.supplier_class.to_s
    belongs_to :project, :class_name => PettyWarehousex.project_class.to_s
    belongs_to :purchase_order, :class_name => PettyWarehousex.purchase_order_class.to_s
    belongs_to :unit, :class_name => 'Commonx::MiscDefinition'

    validates :storage_location, :in_date, :presence => true
    validates_numericality_of :in_qty
    validates :stock_qty, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => :in_qty}
    validates_numericality_of :item_id, :only_integer => true, :greater_than => 0, :if => 'item_id.present?'
    validates_numericality_of :project_id, :only_integer => true, :greater_than => 0, :if => 'project_id.present?'
    validates_numericality_of :purchase_order_id, :greater_than => 0, :if => 'purchase_order_id.present?'
    validates_numericality_of :total_cost, :greater_than_or_equal_to => 0, :if => 'total_cost.present?'
    validates_numericality_of :unit_price, :greater_than_or_equal_to => 0, :if => 'unit_price.present?'
    validates_numericality_of :item_category_id, :only_integer => true, :greater_than => 0, :if => 'item_category_id.present?'
    validates_numericality_of :item_sub_category_id, :only_integer => true, :greater_than => 0, :if => 'item_sub_category_id.present?'
    validates_numericality_of :supplier_id, :only_integer => true, :greater_than => 0, :if => 'supplier_id.present?'
    validates_numericality_of :unit_id, :only_integer => true, :greater_than => 0, :if => 'unit_id.present?'
    validate :dynamic_validate
    
    def dynamic_validate
      wf = Authentify::AuthentifyUtility.find_config_const('dynamic_validate', 'petty_warehousex')
      eval(wf) if wf.present?
    end
  end
end
