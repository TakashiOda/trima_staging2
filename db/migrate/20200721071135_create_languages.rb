class CreateLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :languages do |t|
      t.string :code
      t.string :name
      t.string :apply_lang
    end
  end
end
