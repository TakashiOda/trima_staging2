FactoryBot.define do
  factory :activity_business do
    supplier                {nil}
    profile_image           {nil}
    name                    {'十勝ラフティングアドベンチャー'}
    en_name                 {'Tokachi Rafting Adventure'}
    cn_name                 {nil}
    tw_name                 {nil}
    profile_text            {'プロフィールです'}
    en_profile_text         {'this is profile'}
    cn_profile_text         {nil}
    tw_profile_text         {nil}
    apply_suuplier_address  {false}
    apply_suuplier_phone    {false}
    post_code               {'001-0002'}
    prefecture_id           {1}
    area_id                 {1}
    town_id                 {1}
    detail_address          {'豊平区美園7条7丁目'}
    building                {'美園ビル701'}
    phone                   {'00011112222'}
    no_charge_cansel_before {'three_days_before'}
    has_insurance           {true}
    guide_certification     {'自然保護ガイド'}
    insurance_image         {nil}
    status                  {'inputing'}
    is_approved             {true}
  end
end
