class CreateActivityCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :activity_courses do |t|
      t.references :activity, null: false, foreign_key: true
      t.integer :start_hour
      t.integer :start_minutes
    end
  end
end
