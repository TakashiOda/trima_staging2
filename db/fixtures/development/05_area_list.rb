require 'csv'

csv = CSV.read('db/fixtures/development/area_list.csv')
csv.each do |area|
  Area.seed_once(:prefecture_id, :en_name) do |ar|
    ar.prefecture_id = area[2]
    ar.en_name = area[3]
    ar.local_name = area[4]
  end
end
