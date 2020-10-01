class ActivityLanguage < ApplicationRecord
  belongs_to :activity_business
  belongs_to :language
end
