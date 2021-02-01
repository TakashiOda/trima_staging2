class CreateProjectMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :project_members do |t|
      t.references :user, null: true, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.string :nickname
      t.string :first_name
      t.string :last_name
      t.integer :birth_year
      t.integer :birth_month
      t.integer :birth_date
      t.string :gender
      t.string :avatar
      t.integer :nationality

      t.timestamps
    end
  end
end
