class CreateSupplierProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :supplier_profiles do |t|
      t.references :supplier, null: false, foreign_key: true
      t.string  :manager_name
      t.string :post_code
      t.integer :prefecture_id
      t.integer :area_id
      t.integer :town_id
      t.string :detail_address
      t.string :building
      t.string :phone
      # t.boolean :has_event, null: false, default: false
      # t.boolean :has_spot, null: false, default: false
      # t.boolean :has_activity, null: false, default: false
      # t.boolean :has_restaurant, null: false, default: false
      t.integer :contract_plan, null: false, default: 0
      t.boolean :is_suspended, null: false, default: false #false:稼働, true:凍結
    end
  end
end
