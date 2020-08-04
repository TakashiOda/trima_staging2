class CreateStates < ActiveRecord::Migration[6.0]
  def change
    create_table :states do |t|
      t.references :country, null: false, foreign_key: true
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
