require 'csv'

csv = CSV.read('db/fixtures/production/language_list.csv')
csv.each do |language|
  Language.seed(:code, :name) do |lan|
    lan.code = language[0]
    lan.name = language[1]
    lan.apply_lang = language[2]
  end
end
