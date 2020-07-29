class CreateTowns < ActiveRecord::Migration[6.0]
  def change
    create_table :towns do |t|
      t.string :town_code
      t.references :country, null: false, foreign_key: true
      t.references :state, null: false, foreign_key: true
      t.references :prefecture, null: false, foreign_key: true
      t.references :area, null: false, foreign_key: true
      t.string :en_name
      t.string :jp_name
      t.string :cn_name
      t.string :tw_name
      t.boolean :is_big_city
      t.string :image
    end
  end
end
