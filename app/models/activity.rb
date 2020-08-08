class Activity < ApplicationRecord
  belongs_to :activity_business
  belongs_to :activity_categories          
end
