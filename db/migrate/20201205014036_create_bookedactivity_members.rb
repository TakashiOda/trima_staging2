class CreateBookedactivityMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :bookedactivity_members do |t|
      t.references :booked_activity, null: false, foreign_key: true
      t.references :project_member, null: false, foreign_key: true
    end
  end
end
