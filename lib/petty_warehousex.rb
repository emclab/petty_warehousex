require "petty_warehousex/engine"

module PettyWarehousex
  mattr_accessor :supplier_class, :index_checkout_path, :checkout_resource
  
  def self.supplier_class
    @@supplier_class.constantize
  end
end
