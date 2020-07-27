require 'csv'

csv = CSV.read('db/fixtures/production/state_list.csv')
csv.each do |state|
  State.seed(:country_id, :en_name) do |st|
    st.country_id = state[0]
    st.en_name = state[1]
    st.local_name = state[2]
  end
end
