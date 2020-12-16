class FavoriteActivity < ApplicationRecord
  belongs_to :user
  belongs_to :activity

  validates :activity_id, uniqueness: { scope: [:user_id, :project_id] }
end
