class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.string :name
      t.references :activity_business, null: false, foreign_key: true
      t.references :activity_category, null: false, foreign_key: true
      t.text :description
      t.string :main_image
      t.integer :activity_minutes

      # 住所情報
      t.integer :state_id
      t.integer :prefecture_id
      t.integer :area_id
      t.integer :town_id
      t.string :detail_address
      t.string :building
      t.float  :longitude
      t.float  :latitude

      #　参加情報
      t.integer :maximum_num, default: 1
      t.integer :minimum_num, default: 5
      t.integer :available_age, default: 6

      #　シーズン情報
      t.boolean :january, default: true
      t.boolean :febrary, default: true
      t.boolean :march, default: true
      t.boolean :april, default: true
      t.boolean :may, default: true
      t.boolean :june, default: true
      t.boolean :july, default: true
      t.boolean :august, default: true
      t.boolean :september, default: true
      t.boolean :october, default: true
      t.boolean :november, default: true
      t.boolean :december, default: true

      #　シーズン料金設定
      t.boolean :has_season_price, default: false
      t.float   :low_price_ratio, default: 0.8
      t.float   :high_price_ratio, default: 1.2

      # 定休日情報
      t.boolean :monday_open, default: true
      t.boolean :tuesday_open, default: true
      t.boolean :wednesday_open, default: true
      t.boolean :thursday_open, default: true
      t.boolean :friday_open, default: true
      t.boolean :saturday_open, default: true
      t.boolean :sunday_open, default: true

      #その他設定
      t.boolean :advertise_activate, default: false #0 => approved, 1 =>not yet
      t.boolean :is_approved, default: false #0 => approved, 1 =>not yet
      t.boolean :activate, default: true

    end
    add_index :activities, :state_id
    add_index :activities, :prefecture_id
    add_index :activities, :area_id
    add_index :activities, :town_id
    add_index :activities, :maximum_num
    add_index :activities, :available_age
    add_index :activities, :january
    add_index :activities, :febrary
    add_index :activities, :march
    add_index :activities, :april
    add_index :activities, :may
    add_index :activities, :june
    add_index :activities, :july
    add_index :activities, :august
    add_index :activities, :september
    add_index :activities, :october
    add_index :activities, :november
    add_index :activities, :december
    add_index :activities, :advertise_activate
    add_index :activities, :is_approved
    add_index :activities, :activate
  end
end
