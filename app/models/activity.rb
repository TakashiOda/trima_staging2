class Activity < ApplicationRecord
  belongs_to :activity_business
  belongs_to :activity_category
  has_many :activity_courses, dependent: :destroy
  accepts_nested_attributes_for :activity_courses, allow_destroy: true

  has_many :activity_ageprices, dependent: :destroy
  accepts_nested_attributes_for :activity_ageprices, allow_destroy: true

  # has_many :activity_stocks, dependent: :destroy
  # accepts_nested_attributes_for :activity_stocks, allow_destroy: true

  mount_uploader :main_image, MainImageUploader

end
