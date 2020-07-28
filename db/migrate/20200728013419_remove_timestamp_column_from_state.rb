class RemoveTimestampColumnFromState < ActiveRecord::Migration[6.0]
  def change
    remove_column :states, :created_at, :datetime
    remove_column :states, :updated_at, :datetime
    remove_column :prefectures, :created_at, :datetime
    remove_column :prefectures, :updated_at, :datetime
  end
end
