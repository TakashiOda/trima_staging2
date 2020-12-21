
User.seed(:email) do |u|
  u.id = 1
  u.email = "hatanaka@uu-hokkaido.com"
  u.password = "password"
  u.first_name = "Takashi"
  u.last_name = "Oda"
  u.username = "Odayan"
  u.confirmed_at = Time.now.utc
end
#
# SupplierProfile.seed(:supplier_id) do |org|
#   org.id = 1
#   org.supplier_id = 1
#   org.manager_name = "斎藤和義"
#   org.prefecture_id = 2
#   org.town_id = 97
#   org.detail_address = "字屈足基線２４０"
#   org.post_code = "081-0154"
#   org.phone = "08044262491"
#   org.has_event = true
#   org.has_spot = true
#   org.has_restaurant = true
#   org.has_activity = true
# end
#
# ActivityBusiness.seed(:id) do |biz|
#   biz.id = 1
#   biz.supplier_id = 1
#   biz.name = "十勝リバーラフティング"
#   biz.profile_text = "十勝川の大自然を感じる十勝リバーラフティング"
#   biz.prefecture_id = 2
#   biz.area_id = 5
#   biz.guide_certification = "1"
# end
