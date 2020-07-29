class Town < ApplicationRecord
  belongs_to :country
  belongs_to :state
  belongs_to :prefecture
  belongs_to :area
end
