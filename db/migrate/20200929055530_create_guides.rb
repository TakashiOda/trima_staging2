class CreateGuides < ActiveRecord::Migration[6.0]
  def change
    create_table :guides do |t|
      t.references :activity_business, null: false, foreign_key: true
      t.string :name
      t.string :avatar
      t.text :introduction
      t.string :roll
      t.boolean :speak_japanese, default: true
      t.boolean :speak_english, default: false
      t.boolean :speak_chinese, default: false
      t.string :other_language
      t.boolean :stop_now, default: false
    end
  end
end
