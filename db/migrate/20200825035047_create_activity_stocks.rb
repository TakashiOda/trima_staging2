class CreateActivityStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :activity_stocks do |t|
      t.references :activity_course, null: false, foreign_key: true
      t.integer :activity_id, null: false
      t.date    :date
      t.integer :stock, default: 0
      t.integer :book_amount, null: false, default: 0
      t.string :season_price, default: "normal"
    end
    add_index :activity_stocks, :date
    add_index :activity_stocks, :stock
    add_index :activity_stocks, [:activity_course_id, :date], unique: true
  end
end
