require "petty_warehousex/engine"

module PettyWarehousex
  mattr_accessor :supplier_class, :index_checkout_path, :checkout_resource, :project_class
  
  def self.supplier_class
    @@supplier_class.constantize
  end
  
  def self.project_class
    @@project_class.constantize
  end
end
