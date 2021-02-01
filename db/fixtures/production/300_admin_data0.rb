Admin.seed(:email) do |ad|
  ad.id = 1
  ad.email = "cedarsdev01@gmail.com"
  ad.password = "password"
  ad.name = "管理者01"
  # ad.confirmed_at = Time.now.utc
end

Admin.seed(:email) do |ad|
  ad.id = 2
  ad.email = "test_admin02@gmail.com"
  ad.password = "password"
  ad.name = "管理者02"
  # ad.confirmed_at = Time.now.utc
end

Admin.seed(:email) do |ad|
  ad.id = 3
  ad.email = "test_admin03@gmail.com"
  ad.password = "password"
  ad.name = "管理者03"
  # ad.confirmed_at = Time.now.utc
end
