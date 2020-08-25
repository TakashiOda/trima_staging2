class CreateActivityStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :activity_stocks do |t|
      t.references :activity_course, null: false, foreign_key: true
      t.date :date
      t.integer :stock
      t.integer :book_amount
      t.integer :left_amount
      t.string :season_price, default: "normal"
    end
    add_index :activity_stocks, :date
    add_index :activity_stocks, :left_amount
  end
end
