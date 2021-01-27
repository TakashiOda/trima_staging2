class Activity < ApplicationRecord
  # relations ****************************************************
  belongs_to :activity_business
  has_many :activity_courses, dependent: :destroy
  accepts_nested_attributes_for :activity_courses, allow_destroy: true

  has_many :activity_ageprices, dependent: :destroy
  accepts_nested_attributes_for :activity_ageprices, allow_destroy: true

  has_many :activity_translations, dependent: :destroy
  accepts_nested_attributes_for :activity_translations, allow_destroy: true
  has_many :favorite_activities, dependent: :destroy

  # 画像アップローダー ****************************************************
  mount_uploader :main_image, MainImageUploader
  mount_uploader :second_image, MainImageUploader
  mount_uploader :third_image, MainImageUploader
  mount_uploader :fourth_image, MainImageUploader

  # バリデーション *********************************************************
  validates  :name, presence: true, length: { maximum: 40, message: "体験名は最大40字までです" }
  validates  :description, presence: true, length: { maximum: 200, message: "体験紹介文は最大200字までです" }
  validates  :notes, length: { maximum: 500, message: "注意事項は最大500字までです" }
  validates  :activity_category_id, presence: true, inclusion: { in: 1..32, message: "が選択されていません" }
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

  validates :area_id, inclusion: { in: 1..11, message: "が選択されていません" }
  validates :town_id, inclusion: { in: 1..179, message: "が選択されていません" }

  validates  :meeting_spot1_japanese_address, length: { maximum: 80, message: "集合場所の住所は最大 %{count} 字までです" }
  validates  :meeting_spot1_japanese_description, length: { maximum: 200, message: "集合場所の詳細説明は最大 %{count} 字までです" }
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
  validates :activity_courses, associated: true
  # 料金関連
  # validate :require_any_ageprice
  # validate :must_have_high_price_if_has_season_price
  # validate :must_have_low_price_if_has_season_price
  # 翻訳関連
  # validates :activity_translations, associated: true

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
    if activity_courses.size >= 2
      start_times = []
      activity_courses.each do |course|
        fixDateTime = course.start_time.change(year: 2020, month: 1, day: 1)
        start_times.push(fixDateTime)
      end
      sort_times = start_times.sort.reverse
      too_short_time_errors = []
      (sort_times.count - 1).times do |i|
        gapMins = (sort_times[i] - sort_times[i+1]) / 60
        if gapMins < activity_minutes
          too_short_time_errors.push('error')
        end
      end
      if too_short_time_errors.include?('error')
        errors.add(:activity_courses, "の間隔は体験時間より大きくしてください")
      end
    end
  end

  # def must_have_low_price_if_has_season_price
  #   if self.activity_ageprices.size > 0 && self.has_season_price
  #     low_price_blank_errors = []
  #     self.activity_ageprices.each do |ageprice|
  #       if ageprice.low_price == nil || ageprice.low_price == ''
  #         low_price_blank_errors.push('error')
  #       end
  #     end
  #     if low_price_blank_errors.include?('error')
  #       errors.add(:activity_ageprices, "のローシーズン料金が未入力です")
  #     end
  #   end
  # end
  #
  # def must_have_high_price_if_has_season_price
  #   if self.activity_ageprices.size > 0 && self.has_season_price
  #     high_price_blank_errors = []
  #     self.activity_ageprices.each do |ageprice|
  #       if ageprice.high_price == nil || ageprice.high_price == ''
  #         high_price_blank_errors.push('error')
  #       end
  #     end
  #     if high_price_blank_errors.include?('error')
  #       errors.add(:activity_ageprices, "のハイシーズン料金が未入力です")
  #     end
  #   end
  # end

  # コース時間は最低１つ必要
  def require_at_least_one_course
    errors.add(:activity_courses, "を1つ以上作成して下さい") if self.activity_courses.blank?
  end

  # コース時間は5個まで
  def require_upto_ten
    errors.add(:activity_courses, "は5以下にして下さい") if self.activity_courses.size >= 6
  end

  # 料金は最低１つ必要
  # def require_any_ageprice
  #   errors.add(:activity_ageprices, "を1つ以上作成して下さい") if activity_ageprices.blank?
  # end
  #
  # # 料金は3個まで
  # def require_upto_ten
  #   errors.add(:activity_ageprices, "は3以下にして下さい") if self.activity_ageprices.size >= 4
  # end

end
