FactoryBot.define do
  factory :activity_ageprice do
    activity
    age_from        {0}
    age_to          {100}
    normal_price    {2000}
    high_price      {3000}
    low_price       {1000}
  end
end
