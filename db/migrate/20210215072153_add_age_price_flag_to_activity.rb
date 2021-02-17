class AddAgePriceFlagToActivity < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :has_different_ageprices, :boolean, default: false, null: false
  end
end
