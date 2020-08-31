class ActivityCourse < ApplicationRecord
  belongs_to :activity
  has_many :activity_stocks, dependent: :destroy

  validates :activity_id, uniqueness: { scope: :start_time }
end
