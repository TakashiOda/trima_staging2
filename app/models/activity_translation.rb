class ActivityTranslation < ApplicationRecord
  belongs_to :activity

  # バリデーション ****************
  validates :language_id,:numericality => {
            :greater_than_or_equal_to => 1,
            :less_than_or_equal_to => 28,
            :message => '翻訳言語情報が正しくありません'
          }
  validates :name, length: {
              maximum: 40,
              message: "は最大40字までです"
            },
            allow_blank: true
  validates :profile_text, length: {
              maximum: 200,
              message: "は最大200字までです"
            },
            allow_blank: true
  validates :notes, length: {
              maximum: 500,
              message: "は最大500字までです"
            }, allow_blank: true
end
