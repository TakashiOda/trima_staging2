Admin.seed(:email) do |ad|
  ad.id = 1
  ad.email = "noreply@cedars.jp"
  ad.password = "password"
  ad.name = "小田貴志"
  # ad.confirmed_at = Time.now.utc
end
