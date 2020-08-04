class CreateAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :areas do |t|
      t.references :country, null: false, foreign_key: true
      t.references :state, null: false, foreign_key: true
      t.references :prefecture, null: false, foreign_key: true
      t.string :en_name
      t.string :local_name
      t.string :cn_name
      t.string :tw_name
      t.string :image
      t.string :map
      t.text :en_introduction
      t.text :jp_introduction
      t.text :cn_introduction
      t.text :tw_introduction
      t.string :nearest_airport
      t.string :nearest_big_city
      t.boolean :season_jan, null: false, default: false
      t.boolean :season_feb, null: false, default: false
      t.boolean :season_mar, null: false, default: false
      t.boolean :season_apr, null: false, default: false
      t.boolean :season_may, null: false, default: false
      t.boolean :season_jun, null: false, default: false
      t.boolean :season_jul, null: false, default: false
      t.boolean :season_aug, null: false, default: false
      t.boolean :season_sep, null: false, default: false
      t.boolean :season_oct, null: false, default: false
      t.boolean :season_nov, null: false, default: false
      t.boolean :season_dec, null: false, default: false
    end
  end
end
