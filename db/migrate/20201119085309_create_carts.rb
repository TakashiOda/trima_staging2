class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.references :project, null: false, foreign_key: true
    end
  end
end
