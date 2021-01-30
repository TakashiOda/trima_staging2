class CreateCountryCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :country_codes do |t|
      t.string :code
      t.string :name_with_num
      t.string :name
    end
  end
end
