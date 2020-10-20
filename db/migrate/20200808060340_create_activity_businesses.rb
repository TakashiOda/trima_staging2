class CreateActivityBusinesses < ActiveRecord::Migration[6.0]
  def change
    create_table :activity_businesses do |t|
      t.references :supplier, null: false, foreign_key: true
      t.string :profile_image
      t.string :name
      t.string :en_name
      t.string :cn_name
      t.string :tw_name
      t.text :profile_text
      t.text :en_profile_text
      t.text :cn_profile_text
      t.text :tw_profile_text
      t.boolean :apply_suuplier_address, default: true
      t.boolean :apply_suuplier_phone, default: true
      t.string :post_code
      t.integer :prefecture_id
      t.integer :area_id
      t.integer :town_id
      t.string :detail_address
      t.string :building
      t.string :phone
      t.boolean :has_insurance, default: false
      t.string :guide_certification
      t.boolean :is_approved, default: false #0 => approved, 1 =>not yet
    end
    add_index :activity_businesses, :prefecture_id
    add_index :activity_businesses, :area_id
    add_index :activity_businesses, :town_id
    add_index :activity_businesses, :has_insurance
    add_index :activity_businesses, :guide_certification
    add_index :activity_businesses, :is_approved
  end
end
