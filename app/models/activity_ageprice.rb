class ActivityAgeprice < ApplicationRecord
  belongs_to :activity

  validates :activity_id, uniqueness: { scope: :age_from }
end
