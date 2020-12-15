class CreateBookedActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :booked_activities do |t|
      t.string :purchase_number
      t.integer :project_id
      t.integer :cart_id
      t.references :activity, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :total_price
      t.date :activity_date
      t.time :activity_start_time
      t.boolean :is_paid, default: false
      t.datetime :purchase_date
      t.integer :supplier_id, null: false
      t.timestamps
    end
  end
end
