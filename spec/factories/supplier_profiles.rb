FactoryBot.define do
  factory :supplier_profile do
    supplier              {nil}
    representative_name   {'代表太郎'}
    representative_kana   {'ダイヒョウタロウ'}
    manager_name          {'担当雅子'}
    manager_name_kana     {'タントウマサコ'}
    post_code             {'001-0003'}
    prefecture_id         {1}
    area_id               {2}
    town_id               {2}
    detail_address        {'豊平区美園7条7丁目5-15'}
    building              {'美園ビル501'}
    phone                 {'01122444244'}
    contract_plan         {0}
    is_suspended          {true}
  end
end
