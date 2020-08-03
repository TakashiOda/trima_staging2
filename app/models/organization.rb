class Organization < ApplicationRecord
  has_many :suppliers, dependent: :destroy
end
