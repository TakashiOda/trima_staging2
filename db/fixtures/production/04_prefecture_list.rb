require 'csv'

csv = CSV.read('db/fixtures/production/prefecture_list.csv')
csv.each do |prefecture|
  Prefecture.seed(:country_id, :state_id, :en_name) do |pre|
    pre.country_id = prefecture[0]
    pre.state_id = prefecture[1]
    pre.en_name = prefecture[2]
    pre.local_name = prefecture[3]
  end
end
