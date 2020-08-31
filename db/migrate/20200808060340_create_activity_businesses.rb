class CreateActivityBusinesses < ActiveRecord::Migration[6.0]
  def change
    create_table :activity_businesses do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :name
      t.string :profile_image
      t.text :profile_text
      t.integer :state_id
      t.integer :prefecture_id
      t.integer :area_id
      t.integer :town_id
      t.string :detail_address
      t.string :building
      t.boolean :apply_org_info, default: true
      t.boolean :apply_org_bank, default: true
      t.boolean :has_insurance, default: false
      t.string :guide_certification
      t.boolean :is_approved, default: false #0 => approved, 1 =>not yet
    end
    add_index :activity_businesses, :state_id
    add_index :activity_businesses, :prefecture_id
    add_index :activity_businesses, :area_id
    add_index :activity_businesses, :town_id
    add_index :activity_businesses, :has_insurance
    add_index :activity_businesses, :guide_certification
    add_index :activity_businesses, :is_approved
  end
end