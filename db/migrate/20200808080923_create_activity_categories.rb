class CreateActivityCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :activity_categories do |t|
      t.string :en_name
      t.string :jp_name
      t.string :cn_name
    end
  end
end
