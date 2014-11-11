module PettyWarehousex
  class Item < ActiveRecord::Base
    attr_accessor :supplier_name, :received_by_name, :item_category_name, :warehouse_name, :project_name, :accepted_noupdate, :purchase_order_id_noupdate, 
                  :field_changed, :name_autocomplete
    attr_accessible :in_date, :in_qty, :item_category_id, :last_updated_by_id, :name, :note, :other_cost, :item_spec, :stock_qty, :storage_location, :supplier_id, 
                    :unit, :unit_price, :inspection, :whs_string, :total_cost, :project_id, :accepted, :accepted_date, :purchase_order_id,
                    :field_changed, :name_autocomplete,
                    :as => :role_new
    attr_accessible :in_date, :in_qty, :item_category_id, :last_updated_by_id, :name, :note, :other_cost, :item_spec, :stock_qty, :storage_location, :supplier_id, 
                    :unit, :unit_price, :inspection, :whs_string, :total_cost, :accepted, :accepted_date, :purchase_order_id,
                    :supplier_name, :received_by_name, :item_category_name, :warehouse_name, :project_name, :accepted_noupdate, :purchase_order_id_noupdate, 
                    :field_changed, :name_autocomplete,
                    :as => :role_update
                    
    attr_accessor   :start_date_s, :end_date_s, :name_s, :item_spec_s, :storage_location_s, :whs_string_s, :item_category_id_s, :supplier_id_s, :project_id_s,
                    :purchase_order_id_s, :accepted_s
                    
    attr_accessible :start_date_s, :end_date_s, :name_s, :item_spec_s, :storage_location_s, :whs_string_s, :item_category_id_s, :supplier_id_s, :project_id_s,
                    :purchase_order_id_s, :accepted_s,
                    :as => :role_search_stats
                    
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :received_by, :class_name => 'Authentify::User'
    belongs_to :item_category, :class_name => 'Commonx::MiscDefinition'
    belongs_to :supplier, :class_name => PettyWarehousex.supplier_class.to_s
    belongs_to :project, :class_name => PettyWarehousex.project_class.to_s
    belongs_to :purchase_order, :class_name => PettyWarehousex.purchase_order_class.to_s

    validates :name, :unit, :storage_location, :in_date, :whs_string, :presence => true
    validates_numericality_of :in_qty, :only_integer => true, :greater_than_or_equal_to => 0
    validates :stock_qty, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => :in_qty}
    validates_numericality_of :project_id, :greater_than => 0, :if => 'project_id.present?'
    validates_numericality_of :purchase_order_id, :greater_than => 0, :if => 'purchase_order_id.present?'
    validates_numericality_of :total_cost, :greater_than => 0, :if => 'total_cost.present?'
    validates_numericality_of :unit_price, :greater_than => 0, :if => 'unit_price.present?'
    validates_numericality_of :item_category_id, :greater_than => 0, :if => 'item_category_id.present?'
    validate :dynamic_validate
    
    def dynamic_validate
      wf = Authentify::AuthentifyUtility.find_config_const('dynamic_validate', 'petty_warehousex')
      eval(wf) if wf.present?
    end
  end
end
