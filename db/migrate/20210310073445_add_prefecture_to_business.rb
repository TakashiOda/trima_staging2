class AddPrefectureToBusiness < ActiveRecord::Migration[6.0]
  def change
    add_column :activity_businesses, :prefecture, :string
    add_column :activity_businesses, :area, :string
    add_column :activity_businesses, :town, :string
  end
end
