class CreateActivityAgeprices < ActiveRecord::Migration[6.0]
  def change
    create_table :activity_ageprices do |t|
      t.references :activity, null: false, foreign_key: true
      t.integer :age_from, null: false, default: 0
      t.integer :age_to, null: false, default: 100
      t.integer :normal_price, null: false, default: 1000
      t.integer :high_price, null: false, default: 1000
      t.integer :low_price, null: false, default: 1000
    end
  end
end
