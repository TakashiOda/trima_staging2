class UserProject < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates  :control_level, inclusion: { in: [0, 1] }
  validates :accept_invite, inclusion: { in: [0, 1] }
end
