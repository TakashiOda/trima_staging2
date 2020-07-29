require 'csv'

csv = CSV.read('db/fixtures/development/area_list.csv')
csv.each do |area|
  Area.seed_once(:state_id, :prefecture_id, :en_name) do |ar|
    ar.country_id = area[0]
    ar.state_id = area[1]
    ar.prefecture_id = area[2]
    ar.en_name = area[3]
    ar.local_name = area[4]
  end
end
