class CreateActivityCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :activity_courses do |t|
      t.references :activity, null: false, foreign_key: true
      t.time :start_time
    end
    add_index :activity_courses, [:activity_id, :start_time], unique: true
  end
end
