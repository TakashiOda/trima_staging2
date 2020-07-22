require 'csv'

csv = CSV.read('db/fixtures/production/country_list.csv')
csv.each do |country|
  Country.seed(:name) do |s|
    s.name = country[0]
  end
end
