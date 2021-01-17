FactoryBot.define do
  factory :activity_course do
    activity
    start_time     { Time.now }
  end
end
