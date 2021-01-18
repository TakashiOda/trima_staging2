FactoryBot.define do
  factory :guide do
    activity_business
    name                  {'佐藤'}
    avatar                {'avatar.jpg'}
    introduction          {'カヌーガイド歴20年'}
    roll                  {'カヌー'}
    speak_japanese        {true}
    speak_english         {true}
    speak_chinese         {false}
    other_language        {nil}
    stop_now              {false}
  end
end
