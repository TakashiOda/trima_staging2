class RemoveCountryIdFromProject < ActiveRecord::Migration[6.0]
  def change
    remove_column :projects, :country_id, :integer
  end
end
