class Prefecture < ApplicationRecord
  belongs_to :country
  belongs_to :state
end
