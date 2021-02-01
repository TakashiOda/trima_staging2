class ActivityCourse < ApplicationRecord

  # リレーション ************************************
  belongs_to :activity
  has_many :activity_stocks, dependent: :destroy # stockはcourseの子モデル、まとめて更新できる
  accepts_nested_attributes_for :activity_stocks, allow_destroy: true

  # バリデーション ************************************
  validates :start_time, presence: true
  validates :activity_id, uniqueness: { scope: :start_time, message: 'のスタート時間が重複しています' }

  # モデルメソッド ************************************
  def display_time
    start_time.strftime("%H:%M〜")
  end

end
