require "petty_warehousex/engine"

module PettyWarehousex
  mattr_accessor :supplier_class, :project_class, :purchase_order_class, :part_class, :checkout_class,
                 :category_class, :sub_category_class, :whs_class
  
  def self.supplier_class
    @@supplier_class.constantize
  end
  
  def self.project_class
    @@project_class.constantize
  end
  
  def self.purchase_order_class
    @@purchase_order_class.constantize
  end
  
  def self.part_class
    @@part_class.constantize
  end
  
  def self.checkout_class
    @@checkout_class.constantize
  end
  
  def self.category_class
    @@category_class.constantize
  end

  def self.sub_category_class
    @@sub_category_class.constantize
  end
  
  def self.whs_class
    @@whs_class.constantize
  end

end
