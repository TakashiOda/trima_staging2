class CreateGuides < ActiveRecord::Migration[6.0]
  def change
    create_table :guides do |t|
      t.references :activity_business, null: false, foreign_key: true
      t.string :name
      t.string :avatar
      t.text :introduction
      t.timestamps
    end
  end
end
