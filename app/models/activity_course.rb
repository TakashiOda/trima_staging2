class ActivityCourse < ApplicationRecord
  belongs_to :activity
  has_many :activity_stocks, dependent: :destroy

  validates :activity_id, presence: true, uniqueness: { scope: :start_time }
end
