class BookedActivity < ApplicationRecord
  belongs_to :activity
  belongs_to :cart
end
