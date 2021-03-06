class ActivityAgeprice < ApplicationRecord
  # relation ***********************************************
  belongs_to :activity # activityの子である

  # validation **********************************************
  # validates :activity_id, uniqueness: { scope: :age_from, message: 'の年齢下限が重複しています' } # "activity_id"と "age_from"は複合ユニーク
  # validates :age_from, numericality: { only_integer: true } # "age_from"は 空でない / 整数のみ
  # validates :age_to, numericality: { only_integer: true } # "age_to"は 空でない / 整数のみ
  validates :normal_price, numericality: { only_integer: true } # "normal_price"は 空でない / 整数のみ

end
