class Cart < ApplicationRecord
  belongs_to :project, optional: true
  has_many :booked_activities, dependent: :destroy
end
