class CreateSupplierProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :supplier_profiles do |t|
      t.references :supplier, null: false, foreign_key: true
      t.string  :representative_name
      t.string  :representative_kana
      t.string  :manager_name
      t.string  :manager_name_kana
      t.string :post_code
      t.integer :prefecture
      t.integer :prefecture_id
      t.integer :area
      t.integer :area_id
      t.integer :town
      t.integer :town_id
      t.string :detail_address
      t.string :building
      t.string :phone
      t.integer :contract_plan, null: false, default: 0
      t.boolean :is_suspended, null: false, default: false #false:稼働, true:凍結
    end
  end
end
