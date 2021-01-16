class CreateActivityLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :activity_languages do |t|
      t.references :activity_business, null: false, foreign_key: true
      t.integer :language_id
    end
    add_index :activity_languages, [:activity_business_id, :language_id], unique: true, name: 'activity_languages_unique_index'
  end
end
