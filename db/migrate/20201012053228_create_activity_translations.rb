class CreateActivityTranslations < ActiveRecord::Migration[6.0]
  def change
    create_table :activity_translations do |t|
      t.references :activity, null: false, foreign_key: true
      t.integer :language_id
      t.string :name
      t.text :profile_text
      t.text :notes
    end
    add_index :activity_translations, [:activity_id, :language_id], unique: true, name: 'activity_translation_unique_index'
  end
end
