
Supplier.seed(:email) do |sup|
  sup.id = 1
  sup.email = "cedarsdev01@gmail.com"
  sup.password = "password"
  sup.name = "株式会社十勝遊戯社"
  sup.confirmed_at = Time.now.utc
end

SupplierProfile.seed(:supplier_id) do |org|
  org.id: 1
  org.supplier_id: 1
  org.representative_name: "札幌太郎"
  org.representative_kana: "サッポロタロウ"
  org.manager_name: "札幌太郎"
  org.manager_name_kana: "サッポロタロウ"
  org.post_code: "081-0154"
  org.prefecture_id: 2
  org.area_id: 1
  org.town_id: 1
  org.detail_address: "字屈足基線２４０"
  org.building: nil
  org.phone: "08044262491"
  org.contract_plan: 0
  org.is_suspended: false
end

ActivityBusiness.seed(:id) do |biz|
  biz.id: 1
  biz.supplier_id: 1
  biz.profile_image: nil
  biz.name: "十勝リバーラフティング"
  biz.en_name: nil
  biz.cn_name: nil
  biz.tw_name: nil
  biz.profile_text: "十勝川の大自然を感じる十勝リバーラフティング"
  biz.en_profile_text: nil
  biz.cn_profile_text: nil
  biz.tw_profile_text: nil
  biz.apply_suuplier_address: true
  biz.apply_suuplier_phone: true
  biz.post_code: nil
  biz.prefecture_id: 2
  biz.area_id: 5
  biz.town_id: nil
  biz.detail_address: nil
  biz.building: nil
  biz.phone: nil
  biz.no_charge_cansel_before: "three_days_before"
  biz.has_insurance: false
  biz.guide_certification: "1"
  biz.insurance_image: nil
  biz.status: "send_approve"
  biz.is_approved: true
end
