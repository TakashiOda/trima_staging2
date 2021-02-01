require 'csv'

csv = CSV.read('db/fixtures/development/country_code.csv')
csv.each do |code|
  CountryCode.seed(:name_with_num) do |lan|
    lan.code = code[0]
    lan.name_with_num = code[1]
    lan.name = code[2]
  end
end
