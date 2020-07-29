require 'csv'

csv = CSV.read('db/fixtures/development/town_list.csv')
csv.each do |town|
  Town.seed(:town_code, :country_id, :en_name) do |to|
    to.town_code = town[0]
    to.country_id = town[1]
    to.state_id = town[2]
    to.prefecture_id = town[3]
    to.area_id = town[4]
    to.en_name = town[5]
    to.jp_name = town[6]
  end
end
