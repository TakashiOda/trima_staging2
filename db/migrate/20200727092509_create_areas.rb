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
      t.string :jp_introduction
      t.string :cn_introduction
      t.string :tw_introduction
      t.string :nearest_airport
      t.string :nearest_big_city
      t.boolean :season_jan
      t.boolean :season_feb
      t.boolean :season_mar
      t.boolean :season_apr
      t.boolean :season_may
      t.boolean :season_jun
      t.boolean :season_jul
      t.boolean :season_aug
      t.boolean :season_sep
      t.boolean :season_oct
      t.boolean :season_nov
      t.boolean :season_dec
    end
  end
end
