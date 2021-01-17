FactoryBot.define do
  factory :activity do
    activity_business_id               {1}
    supplier_id                        {1}
    activity_category_id               {1}
    name                               {'十勝川ラフティング'}
    description                        {'楽しいよ'}
    notes                              {'濡れても良い服装必須'}
    main_image                         {nil}
    second_image                       {nil}
    third_image                        {nil}
    fourth_image                       {nil}
    activity_minutes                   {90}
    prefecture_id                      {1}
    area_id                            {1}
    town_id                            {1}
    detail_address                     {nil}
    building                           {nil}
    longitude                          {141.77281695938285}
    latitude                           {43.25299917008218}
    meeting_spot1_japanese_address     {'前平橋駐車場'}
    meeting_spot1_japanese_description {'前平橋駐車場は橋から下流を見て左側にあります'}
    meeting_spot1_longitude            {141.77281695938285}
    meeting_spot1_latitude             {43.25299917008218}
    maximum_num                        {5}
    minimum_num                        {2}
    available_age                      {6}
    january                            {true}
    febrary                            {true}
    march                              {true}
    april                              {true}
    may                                {true}
    june                               {true}
    july                               {true}
    august                             {true}
    september                          {true}
    october                            {true}
    november                           {true}
    december                           {false}
    is_all_year_open                   {true}
    start_date                         {'2020/12/12'}
    end_date                           {'2020/02/16'}
    normal_adult_price                 {1000}
    has_season_price                   {true}
    monday_open                        {true}
    tuesday_open                       {true}
    thursday_open                      {true}
    friday_open                        {true}
    saturday_open                      {true}
    sunday_open                        {true}
    rain_or_shine                      {false}
    status                             {'draft'}
    is_approved                        {false}
    stop_now                           {false}
    activity_courses {
      [FactoryBot.build(:activity_course, activity: nil)]
    }
    activity_ageprices {
      [FactoryBot.build(:activity_ageprice, activity: nil)]
    }
  end
end
