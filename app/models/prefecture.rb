class Prefecture < ApplicationRecord
  has_many :areas
  has_many :towns

  validates :en_name,  length: { maximum: 40, too_long: "Maximum %{count} characters" }, allow_nil: true
  validates :local_name,  length: { maximum: 40, too_long: "Maximum %{count} characters" }, allow_nil: true
  validates :cn_name,  length: { maximum: 20, too_long: "Maximum %{count} characters" }, allow_nil: true
  validates :tw_name,  length: { maximum: 20, too_long: "Maximum %{count} characters" }, allow_nil: true
  validates :en_introduction,  length: { maximum: 400, too_long: "Maximum %{count} characters" }, allow_nil: true
  validates :jp_introduction,  length: { maximum: 400, too_long: "Maximum %{count} characters" }, allow_nil: true
  validates :cn_introduction,  length: { maximum: 400, too_long: "Maximum %{count} characters" }, allow_nil: true
  validates :tw_introduction,  length: { maximum: 400, too_long: "Maximum %{count} characters" }, allow_nil: true

end
