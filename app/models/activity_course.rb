class ActivityCourse < ApplicationRecord
  belongs_to :activity
  has_many :activity_stocks, dependent: :destroy
end
