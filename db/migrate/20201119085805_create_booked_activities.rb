class CreateBookedActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :booked_activities do |t|
      t.string     :purchase_number
      t.integer    :project_id
      t.integer    :cart_id
      t.references :activity, null: false, foreign_key: true
      t.string     :activity_name
      t.integer    :course_id, null: false
      t.integer    :stock_id, null: false
      t.references :user, null: false, foreign_key: true
      t.string     :user_name
      t.integer    :total_participants
      t.integer    :total_price
      t.date       :activity_date
      t.time       :activity_start_time
      t.time       :activity_end_time
      t.boolean    :is_paid, default: false
      t.datetime   :purchase_date
      t.integer    :supplier_id, null: false
      t.timestamps
    end
  end
end
