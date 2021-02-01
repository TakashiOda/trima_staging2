require 'csv'

csv = CSV.read('db/fixtures/development/town_list.csv')
csv.each do |town|
  Town.seed(:jp_name, :en_name) do |to|
    to.prefecture_id = town[3]
    to.area_id = town[4]
    to.en_name = town[5]
    to.jp_name = town[6]
  end
end
