class ActivityBusiness < ApplicationRecord
  belongs_to :organization
  has_many :activities, dependent: :destroy
end
