class CreateProjectAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :project_areas do |t|
      t.references :project, null: false, foreign_key: true
      t.references :area, null: false, foreign_key: true
    end
    add_index :project_areas, [:project_id, :area_id], unique: true
  end
end
