class ActivityLanguage < ApplicationRecord
  belongs_to :activity_business
  belongs_to :language

  validates :language_id, presence: true,
            :numericality => {
              :greater_than_or_equal_to => 1,
              :less_than_or_equal_to => 28,
              :message => '対応可能言語が正しくありません'
            }
end
