class BookedactivityMember < ApplicationRecord
  belongs_to :booked_activity
  belongs_to :project_member
end
