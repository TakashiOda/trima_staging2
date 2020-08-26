Organization.seed(:id) do |org|
  org.id = 1
  org.org_type = "企業"
  org.name = "十勝アウトドアメイツ"
  org.state_id = 1
  org.prefecture_id = 2
  org.town_id = 97
  org.detail_address = "字屈足基線２４０"
  org.post_code = "081-0154"
  org.phone = "08044262491"
  org.has_event = true
  org.has_spot = true
  org.has_restaurant = true
  org.has_activity = true
end

Supplier.seed(:email) do |sup|
  sup.id = 1
  sup.email = "takashi.oda@ccc.ne.jp"
  sup.password = "password"
  sup.name = "Takashi Oda"
  sup.confirmed_at = Time.now.utc
  sup.organization_id = 1
end

ActivityBusiness.seed(:id) do |biz|
  biz.id = 1
  biz.organization_id = 1
  biz.name = "十勝リバーラフティング"
  biz.profile_text = "十勝川の大自然を感じる十勝リバーラフティング"
  biz.prefecture_id = 2
  biz.area_id = 5
  biz.guide_certification = "1"
end
