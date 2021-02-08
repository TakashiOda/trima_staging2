class AddInputStatusToActivityBusiness < ActiveRecord::Migration[6.0]
  def change
    add_column :activity_businesses, :profile_input_done, :boolean, default: false, null: false
    add_column :activity_businesses, :cansel_input_done, :boolean, default: false, null: false
    add_column :activity_businesses, :insurance_input_done, :boolean, default: false, null: false
  end
end
