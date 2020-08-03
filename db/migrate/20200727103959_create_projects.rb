class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name
      # t.references :owner_user, foreign_key: { to_table: :users }
      # t.references :country, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.string :start_place
      t.string :end_place
      # t.integer :destination_area, foreign_key: { to_table: :areas }

      t.timestamps
    end
  end
end
