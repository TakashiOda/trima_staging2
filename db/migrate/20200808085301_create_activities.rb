class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.string :name
      t.references :activity_business, null: false, foreign_key: true
      t.integer :supplier_id, null: false
      t.integer :activity_category_id, default: 1
      t.text    :description
      t.text    :notes
      t.string  :main_image
      t.string  :second_image
      t.string  :third_image
      t.string  :fourth_image
      t.integer :activity_minutes, default: 60

      # 住所情報
      t.integer :prefecture_id
      t.integer :area_id
      t.integer :town_id
      t.string  :detail_address
      t.string  :building
      t.float   :longitude
      t.float   :latitude

      # 集合場所1
      t.string  :meeting_spot1_japanese_address
      t.text    :meeting_spot1_japanese_description
      t.float   :meeting_spot1_longitude
      t.float   :meeting_spot1_latitude

      #　参加条件
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

      #期間設定
      t.boolean :is_all_year_open, default: true
      t.date    :start_date
      t.date    :end_date

      #　シーズン料金設定
      t.boolean :has_season_price, default: false
      t.integer :normal_adult_price
      t.integer :high_adult_price
      t.integer :low_adult_price
      t.integer :normal_middle_price
      t.integer :high_middle_price
      t.integer :low_middle_price
      t.integer :normal_kids_price
      t.integer :high_kids_price
      t.integer :low_kids_price

      # 定休日情報
      t.boolean :monday_open, default: true
      t.boolean :tuesday_open, default: true
      t.boolean :wednesday_open, default: true
      t.boolean :thursday_open, default: true
      t.boolean :friday_open, default: true
      t.boolean :saturday_open, default: true
      t.boolean :sunday_open, default: true

      #その他設定
      t.boolean :rain_or_shine, default: false #false=>雨天中止 true=>雨天決行
      t.string :status, default: 'draft' #draft, published, deleted
      t.boolean :is_approved, default: false #0 => approved, 1 =>not yet
      t.boolean :stop_now, default: false

      t.timestamps
    end
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
    add_index :activities, :is_approved
    add_index :activities, :stop_now
    add_index :activities, :is_all_year_open
    add_index :activities, :start_date
    add_index :activities, :end_date
  end
end
