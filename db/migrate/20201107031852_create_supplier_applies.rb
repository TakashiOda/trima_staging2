class CreateSupplierApplies < ActiveRecord::Migration[6.0]
  def change
    create_table :supplier_applies do |t|
      t.string :company
      t.string :name
      t.integer :prefecture
      t.integer :town
      t.string :address
      t.string :phone
      t.string :email
      t.boolean :agree_term, default: false

      t.timestamps
    end
  end
end
