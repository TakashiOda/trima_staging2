require 'csv'

csv = CSV.read('db/fixtures/development/prefecture_list.csv')
csv.each do |prefecture|
  Prefecture.seed(:local_name, :en_name) do |pre|
    pre.en_name = prefecture[2]
    pre.local_name = prefecture[3]
  end
end
