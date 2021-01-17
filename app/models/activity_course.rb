class ActivityCourse < ApplicationRecord
  belongs_to :activity

  # stockはcourseの子モデル、まとめて更新できる
  has_many :activity_stocks, dependent: :destroy
  accepts_nested_attributes_for :activity_stocks, allow_destroy: true

  validates :start_time, presence: true
  validates :activity_id, uniqueness: { scope: :start_time, message: 'のスタート時間が重複しています' }

  def display_time
    start_time.strftime("%H:%M〜")
  end

end
