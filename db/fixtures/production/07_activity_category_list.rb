require 'csv'
csv = CSV.read('db/fixtures/development/activity_categories.csv')
csv.each do |data|
  ActivityCategory.seed(:en_name) do |model|
    model.en_name = data[0]
    model.jp_name = data[1]
  end
end
