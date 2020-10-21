
Supplier.seed(:email) do |sup|
  sup.id = 1
  sup.email = "takashi.oda@ccc.ne.jp"
  sup.password = "password"
  sup.name = "Takashi Oda"
  sup.confirmed_at = Time.now.utc
end

SupplierProfile.seed(:supplier_id) do |org|
  org.id = 1
  org.supplier_id = 1
  org.manager_name = "斎藤和義"
  org.prefecture_id = 2
  org.town_id = 97
  org.detail_address = "字屈足基線２４０"
  org.post_code = "081-0154"
  org.phone = "08044262491"
  # org.has_event = true
  # org.has_spot = true
  # org.has_restaurant = true
  # org.has_activity = true
end

ActivityBusiness.seed(:id) do |biz|
  biz.id = 1
  biz.supplier_id = 1
  biz.name = "十勝リバーラフティング"
  biz.profile_text = "十勝川の大自然を感じる十勝リバーラフティング"
  biz.prefecture_id = 2
  biz.area_id = 5
  biz.guide_certification = "1"
end

# 二人目***********************************
Supplier.seed(:email) do |sup|
  sup.id = 2
  sup.email = "hatanaka@ccc.ne.jp"
  sup.password = "password"
  sup.name = "no name"
  sup.confirmed_at = Time.now.utc
end

SupplierProfile.seed(:supplier_id) do |org|
  org.id = 2
  org.supplier_id = 2
  org.manager_name = "部長"
  org.prefecture_id = 2
  org.town_id = 97
  org.detail_address = ""
  org.post_code = ""
  org.phone = ""
end

# 三人目***********************************
Supplier.seed(:email) do |sup|
  sup.id = 3
  sup.email = "kaori.hirata@ccc.ne.jp"
  sup.password = "password"
  sup.name = "no name"
  sup.confirmed_at = Time.now.utc
end
SupplierProfile.seed(:supplier_id) do |org|
  org.id = 3
  org.supplier_id = 3
  org.manager_name = "no name"
  org.prefecture_id = 2
  org.town_id = 97
  org.detail_address = ""
  org.post_code = ""
  org.phone = ""
end
# ４人目***********************************
Supplier.seed(:email) do |sup|
  sup.id = 4
  sup.email = "natsumi.taguchi@ccc.ne.jp"
  sup.password = "password"
  sup.name = "no name"
  sup.confirmed_at = Time.now.utc
end

SupplierProfile.seed(:supplier_id) do |org|
  org.id = 4
  org.supplier_id = 4
  org.manager_name = "no name"
  org.prefecture_id = 2
  org.town_id = 97
  org.detail_address = ""
  org.post_code = ""
  org.phone = ""
end
# SupplierProfile.seed(:supplier_id) do |org|
#   org.id = 2
#   org.supplier_id = 2
#   org.manager_name = "部長"
#   org.prefecture_id = 2
#   org.town_id = 97
#   org.detail_address = ""
#   org.post_code = ""
#   org.phone = ""
# end
