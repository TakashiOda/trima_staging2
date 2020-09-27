class ActivityStock < ApplicationRecord
  # belongs_to :activity
  belongs_to :activity_course

  validates :date, presence: true
  validates :season_price, presence: true
end
