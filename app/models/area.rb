class Area < ApplicationRecord
  belongs_to :country
  belongs_to :state
  belongs_to :prefecture
end
