class CreateTowns < ActiveRecord::Migration[6.0]
  def change
    create_table :towns do |t|
      t.references :prefecture, null: false, foreign_key: true
      t.references :area, null: false, foreign_key: true
      t.string :en_name
      t.string :jp_name
      t.string :cn_name
      t.string :tw_name
      t.text :en_introduction
      t.text :jp_introduction
      t.text :cn_introduction
      t.text :tw_introduction
      t.boolean :is_big_city
      t.string :image
    end
    add_index :towns, :en_name
    add_index :towns, :jp_name
    add_index :towns, :cn_name
    add_index :towns, :tw_name
  end
end
