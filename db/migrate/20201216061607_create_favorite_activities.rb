class CreateFavoriteActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_activities do |t|
      t.references :user, null: false, foreign_key: true
      t.references :activity, null: false, foreign_key: true
      t.integer    :project_id
    end
  end
end
