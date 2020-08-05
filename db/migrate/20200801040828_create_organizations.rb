class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.string :org_type
      t.string :name, null: false
      t.integer :state_id
      t.integer :prefecture_id
      t.integer :town_id
      t.string :detail_address
      t.string :building
      t.string :post_code
      t.string :phone
      t.boolean :has_event, null: false, default: false
      t.boolean :has_spot, null: false, default: false
      t.boolean :has_activity, null: false, default: false
      t.boolean :has_restaurant, null: false, default: false
      t.integer :contract_plan, null: false, default: 0
      t.integer :contract_status, null: false, default: 1 #0:契約済, 1:未契約
    end
    add_index :organizations, :state_id
    add_index :organizations, :prefecture_id
    add_index :organizations, :town_id
    add_index :organizations, :phone
    add_index :organizations, :contract_plan
    add_index :organizations, :contract_status
  end
end
