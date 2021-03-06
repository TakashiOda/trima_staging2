class CreatePrefectures < ActiveRecord::Migration[6.0]
  def change
    create_table :prefectures do |t|
      t.string :en_name
      t.string :local_name
      t.string :cn_name
      t.string :tw_name
      t.text :en_introduction
      t.text :jp_introduction
      t.text :cn_introduction
      t.text :tw_introduction
      t.string :image
    end
  end
end
