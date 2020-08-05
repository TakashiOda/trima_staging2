class CreateProjectInvites < ActiveRecord::Migration[6.0]
  def change
    create_table :project_invites do |t|
      t.references :project, null: false, foreign_key: true
      t.references :inviter, foreign_key: { to_table: :users }
      t.string :invited_email
      t.integer :accept_invite, default: 1 #0 => accepted, 1 =>waiting
      t.integer :has_account, default: 1 #0 => created, 1 =>not yet

      t.timestamps
    end
    add_index :project_invites, :invited_email
  end
end
