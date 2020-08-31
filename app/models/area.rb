class Area < ApplicationRecord
  belongs_to :prefecture

  validates :en_name,  length: { maximum: 20, too_long: "Maximum %{count} characters" }
  validates :local_name,  length: { maximum: 20, too_long: "Maximum %{count} characters" }
  validates :cn_name,  length: { maximum: 20, too_long: "Maximum %{count} characters" }, allow_nil: true
  validates :tw_name,  length: { maximum: 20, too_long: "Maximum %{count} characters" }, allow_nil: true
  validates :en_introduction,  length: { maximum: 400, too_long: "Maximum %{count} characters" }, allow_nil: true
  validates :jp_introduction,  length: { maximum: 400, too_long: "Maximum %{count} characters" }, allow_nil: true
  validates :cn_introduction,  length: { maximum: 400, too_long: "Maximum %{count} characters" }, allow_nil: true
  validates :tw_introduction,  length: { maximum: 400, too_long: "Maximum %{count} characters" }, allow_nil: true
  validates :nearest_airport,  length: { maximum: 30, too_long: "Maximum %{count} characters" }, allow_nil: true
  validates :nearest_big_city,  length: { maximum: 20, too_long: "Maximum %{count} characters" }, allow_nil: true
  validates :nearest_big_city,  length: { maximum: 20, too_long: "Maximum %{count} characters" }, allow_nil: true
  validates :season_jan, inclusion: {in: [true, false]}
  validates :season_feb, inclusion: {in: [true, false]}
  validates :season_mar, inclusion: {in: [true, false]}
  validates :season_apr, inclusion: {in: [true, false]}
  validates :season_may, inclusion: {in: [true, false]}
  validates :season_jun, inclusion: {in: [true, false]}
  validates :season_jul, inclusion: {in: [true, false]}
  validates :season_aug, inclusion: {in: [true, false]}
  validates :season_sep, inclusion: {in: [true, false]}
  validates :season_oct, inclusion: {in: [true, false]}
  validates :season_nov, inclusion: {in: [true, false]}
  validates :season_dec, inclusion: {in: [true, false]}

end
