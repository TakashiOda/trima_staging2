class Activity < ApplicationRecord
  belongs_to :activity_business
  belongs_to :activity_category
  has_many :activity_courses, dependent: :destroy
  accepts_nested_attributes_for :activity_courses, allow_destroy: true
  has_many :activity_ageprices, dependent: :destroy
  accepts_nested_attributes_for :activity_ageprices, allow_destroy: true
  has_many :activity_translations, dependent: :destroy
  accepts_nested_attributes_for :activity_translations, allow_destroy: true

  has_many :favorite_activities, dependent: :destroy

  # 画像アップローダー****************************************************
  mount_uploader :main_image, MainImageUploader
  mount_uploader :second_image, MainImageUploader
  mount_uploader :third_image, MainImageUploader
  mount_uploader :fourth_image, MainImageUploader

  #バリデーション*********************************************************
  validates  :name, presence: true, length: { maximum: 40, too_long: "体験名は最大 %{count} 字までです" }
  validates  :description, presence: true, length: { maximum: 200, too_long: "体験紹介文は最大 %{count} 字までです" }
  validates  :notes, length: { maximum: 500, too_long: "注意事項は最大 %{count} 字までです" }
  validates  :activity_category_id, presence: true
  validates  :available_age, presence: true,
             :numericality => {
               :greater_than_or_equal_to => 0,
               :less_than_or_equal_to => 100,
               :message => '参加可能年齢は0~100歳の範囲で指定してください'
             }
  validates  :minimum_num, presence: true,
             :numericality => {
               :greater_than_or_equal_to => 1,
               :less_than_or_equal_to => 50,
               :message => '最少催行人数は1~50人の範囲で指定してください'
             }
  validates  :maximum_num, presence: true,
             :numericality => {
               :greater_than_or_equal_to => 1,
               :less_than_or_equal_to => 50,
               :message => '最大参加可能人数は1~50人の範囲で指定してください'
             }
  validates  :activity_minutes, presence: true,
             :numericality => {
               :greater_than_or_equal_to => 20,
               :less_than_or_equal_to => 480,
               :message => '体験時間の分数は20~480分の範囲で指定してください'
             }
  validate :area_cant_be_blank
  validate :town_cant_be_blank

  validates  :meeting_spot1_japanese_address, length: { maximum: 80, too_long: "集合場所の住所は最大 %{count} 字までです" }
  validates  :meeting_spot1_japanese_description, length: { maximum: 200, too_long: "集合場所の詳細説明は最大 %{count} 字までです" }
  validates :latitude , allow_blank: true,
            numericality: {
              greater_than_or_equal_to:  -90,
              less_than_or_equal_to:  90,
              :message => '実施場所の緯度は-90から90までの数字で入力してください'
            }
  validates :longitude , allow_blank: true,
            numericality: {
              greater_than_or_equal_to:  -180,
              less_than_or_equal_to:  180,
              :message => '実施場所の経度は-90から90までの数字で入力してください'
            }

  validate :limitedOpen_require_date
  #　コース時間関連
  validate :require_at_least_one_course
  validate :require_upto_ten
  validate :course_gap_less_than_activity_time
  # 料金関連
  validate :require_any_ageprice

  def area_cant_be_blank
    if self.area_id.nil?
      errors.add(:実施エリア, "を設定して下さい")
    end
  end

  def town_cant_be_blank
    if !self.town_id.nil?
      @town = Town.find(self.town_id)
      if @town.en_name.include?('--')
        errors.add(:市区町村, "が適正ではありません")
      end
    end
  end

  #体験が期間限定の場合にデータ空を許容しない
  def limitedOpen_require_date
    if !self.is_all_year_open
      if self.start_date.nil? || self.end_date.nil?
        errors.add(:実施期間, "の開始日と終了日を設定して下さい")
      end
    end
  end

  #コースの間隔が体験時間より小さくなることは許容しない
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


  # コース時間は最低１つ必要
  def require_at_least_one_course
    errors.add(:コース時間, "を1つ以上作成して下さい") if activity_courses.blank?
  end

  # コース時間は5個まで
  def require_upto_ten
    errors.add(:コース時間, "は5以下にして下さい") if self.activity_courses.size >= 6
  end

  # 料金は最低１つ必要
  def require_any_ageprice
    errors.add(:料金, "を1つ以上作成して下さい") if activity_ageprices.blank?
  end

  # 料金は3個まで
  def require_upto_ten
    errors.add(:料金, "は3以下にして下さい") if self.activity_ageprices.size >= 4
  end

end
