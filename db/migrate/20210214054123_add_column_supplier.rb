class AddColumnSupplier < ActiveRecord::Migration[6.0]
  def change
    add_column :suppliers, :profile_set_done, :boolean, default: false, null: false
  end
end
