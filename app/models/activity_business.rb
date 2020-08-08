class ActivityBusiness < ApplicationRecord
  belongs_to :organization
  has_many :activities
end
