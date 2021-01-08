class ActivityAgeprice < ApplicationRecord
  # relation ***********************************************
  belongs_to :activity # activityの子である

  # validation **********************************************
  validates :activity_id, uniqueness: { scope: :age_from } # "activity_id"と "age_from"は複合ユニーク
  validates :age_from, presence: true, numericality: { only_integer: true } # "age_from"は 空でない / 整数のみ
  validates :age_to, presence: true, numericality: { only_integer: true } # "age_to"は 空でない / 整数のみ
  validates :normal_price, presence: true, numericality: { only_integer: true } # "normal_price"は 空でない / 整数のみ
  validates :high_price, presence: true, numericality: { only_integer: true } # "high_price"は 空でない / 整数のみ
  validates :low_price, presence: true, numericality: { only_integer: true } # "low_price"は 空でない / 整数のみ
end
