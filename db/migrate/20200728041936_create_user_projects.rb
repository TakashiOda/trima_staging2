class CreateUserProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :user_projects do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.integer :control_level, default: 0 #0 => owner, 1 =>editor
      t.integer :accept_invite, default: 0 #0 => accepted, 1 =>waiting
    end
    add_index :user_projects, [:user_id, :project_id], unique: true
  end
end
