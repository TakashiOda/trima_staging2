class BookedActivity < ApplicationRecord
  belongs_to :activity
  belongs_to :cart

  has_many :bookedactivity_members, dependent: :destroy
  has_many :project_members, through: :bookedactivity_members
  accepts_nested_attributes_for :bookedactivity_members
end
