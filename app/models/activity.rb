class Activity < ApplicationRecord
  belongs_to :activity_business
  belongs_to :activity_category
  has_many :activity_courses, dependent: :destroy
  accepts_nested_attributes_for :activity_courses, allow_destroy: true
end
