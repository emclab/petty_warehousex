class CreatePettyWarehousexItems < ActiveRecord::Migration
  def change
    create_table :petty_warehousex_items do |t|
      t.string :name
      t.date :in_date
      t.integer :in_qty
      t.string :item_spec
      t.integer :last_updated_by_id
      t.integer :stock_qty
      t.text :note
      t.string :storage_location
      t.text :inspection
      t.timestamps
      t.string :unit
      t.integer :supplier_id
      t.decimal :unit_price, :precision => 10, :scale => 2
      t.integer :item_category_id
      t.decimal :other_cost, :precision => 10, :scale => 2
      t.integer :received_by_id
      t.string :whs_string   #warehouse name. used to allow access to each individual whs.
      t.decimal :total_cost, :precision => 10, :scale => 2
      t.integer :project_id
      
    end
    
    add_index :petty_warehousex_items, :name
    add_index :petty_warehousex_items, :item_category_id
    add_index :petty_warehousex_items, :received_by_id
    add_index :petty_warehousex_items, :whs_string
    add_index :petty_warehousex_items, :item_spec
    add_index :petty_warehousex_items, :project_id
  end
end
