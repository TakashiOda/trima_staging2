require 'csv'

csv = CSV.read('db/fixtures/development/activities.csv')
csv.each do |data|
  Activity.seed(:id) do |act|
    act.id = data[0]
    act.name = data[1]
    act.activity_business_id = data[2]
    act.activity_category_id = data[3]
    act.description = data[4]
    act.main_image = File.open("./db/fixtures/development/activity_images/act_seed_#{data[5]}.jpg")
    act.activity_minutes = data[6]
    act.maximum_num = data[7]
    act.minimum_num = data[8]
    act.available_age = data[9]
    act.normal_adult_price = data[10]
    act.has_season_price = data[11]
  end
end

# 4.times do |n|
#   n = n + 1
#   @act = Activity.find_by(id: n)
#   @act.activity_business_id = 1
#   @act.activity_category_id = 1
#   @act.main_image = File.open("./db/fixtures/development/activity_images/act_seed_#{n}.jpg")
#   @act.save!
# end
# Activity.seed do |act|
#   act.id = 1
#   act.activity_business_id = 1
#   act.activity_category_id = 1
#   act.main_image = File.open("./db/fixtures/development/activity_images/act_seed_0.jpg")
# end
# Activity.seed do |act|
#   act.id = 2
#   act.activity_business_id = 1
#   act.activity_category_id = 1
#   act.main_image = File.open("./db/fixtures/development/activity_images/act_seed_1.jpg")
# end
# Activity.seed do |act|
#   act.id = 3
#   act.activity_business_id = 1
#   act.activity_category_id = 1
#   act.main_image = File.open("./db/fixtures/development/activity_images/act_seed_2.jpg")
# end
# Activity.seed do |act|
#   act.id = 4
#   act.activity_business_id = 1
#   act.activity_category_id = 1
#   act.main_image = File.open("./db/fixtures/development/activity_images/act_seed_3.jpg")
# end
