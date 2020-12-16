class ProjectMember < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :project

  has_many :bookedactivity_members, dependent: :destroy
  has_many :booked_activities, through: :bookedactivity_members
end
