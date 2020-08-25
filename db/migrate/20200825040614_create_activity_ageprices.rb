class CreateActivityAgeprices < ActiveRecord::Migration[6.0]
  def change
    create_table :activity_ageprices do |t|
      t.references :activity, null: false, foreign_key: true
      t.integer :age_from
      t.integer :age_to
      t.integer :price
    end
  end
end
