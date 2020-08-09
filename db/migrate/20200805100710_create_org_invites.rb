class CreateOrgInvites < ActiveRecord::Migration[6.0]
  def change
    create_table :org_invites do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :inviter, foreign_key: { to_table: :suppliers }
      t.string :invited_email
      t.integer :accept_invite, default: 1 #0 => accepted, 1 =>waiting
      t.integer :has_account, default: 1 #0 => created, 1 =>not yet

      t.timestamps
    end
  end
end
