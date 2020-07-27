class CreateStates < ActiveRecord::Migration[6.0]
  def change
    create_table :states do |t|
      t.references :country, null: false, foreign_key: true
      t.string :en_name
      t.string :local_name
      t.string :cn_name
      t.string :tw_name

      t.timestamps
    end
  end
end
