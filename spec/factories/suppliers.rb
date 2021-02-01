FactoryBot.define do
  factory :supplier do
    name                        {"abe"}
    email                       {"kkk@gmail.com"}
    password                    {"00000000"}
    password_confirmation       {"00000000"}
    confirmed_at                { Date.today }
  end
end
