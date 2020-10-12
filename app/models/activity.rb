class Activity < ApplicationRecord
  belongs_to :activity_business
  belongs_to :activity_category
  has_many :activity_courses, dependent: :destroy
  accepts_nested_attributes_for :activity_courses, allow_destroy: true
  has_many :activity_ageprices, dependent: :destroy
  accepts_nested_attributes_for :activity_ageprices, allow_destroy: true

  has_many :activity_translations, dependent: :destroy
  accepts_nested_attributes_for :activity_translations, allow_destroy: true

  mount_uploader :main_image, MainImageUploader
  mount_uploader :second_image, MainImageUploader
  mount_uploader :third_image, MainImageUploader
  mount_uploader :fourth_image, MainImageUploader

  #バリデーション
  validate :limitedOpen_require_date
  #　コース時間関連
  validate :require_at_least_one_course
  validate :require_upto_ten
  validate :course_gap_less_than_activity_time
  # 料金関連
  validate :require_any_ageprice

  def limitedOpen_require_date
    if !self.is_all_year_open
      if self.start_date.nil? || self.end_date.nil?
        errors.add(:実施期間, "の開始日と終了日を設定して下さい")
      end
    end
  end

  def course_gap_less_than_activity_time
    if activity_courses.size > 1
      start_times = []
      activity_courses.each do |course|
        start_times.push(course.start_time)
      end
      sort_times = start_times.sort
      times_count = sort_times.count - 1
      too_short_time_errors = []
      times_count.times do |i|
        if ((sort_times[i+1] - sort_times[i])/60) < self.activity_minutes
          too_short_time_errors.push('error')
        end
      end
      if too_short_time_errors.include?('error')
        errors.add(:コース時間, "の間隔は体験時間より大きくしてください") if too_short_time_errors.include?('error')
      end
    end
  end

  def require_at_least_one_course
    errors.add(:コース時間, "を1つ以上作成して下さい") if activity_courses.blank?
  end

  def require_upto_ten
    errors.add(:コース時間, "は10コース以下にして下さい") if self.activity_courses.size >= 11
  end

  def require_any_ageprice
    errors.add(:料金, "を1つ以上作成して下さい") if activity_ageprices.blank?
  end

end
