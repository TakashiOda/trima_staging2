class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.string :start_place
      t.string :end_place
      t.string :icon, default: 'project_icon-01'
    end
  end
end
