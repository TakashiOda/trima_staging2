require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory  = ENV['S3_BUCKET']
    # config.asset_host = 'https://s3.amazonaws.com/trima-images'
    config.asset_host = 'https://trima-images.s3.amazonaws.com' #このように修正
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['S3_ACCESS_KEY'],
      aws_secret_access_key: ENV['S3_SECRET_KEY'],
      region: 'ap-southeast-1',
      path_style: true
    }
  else
    config.storage :file
    # config.enable_processing = false if Rails.env.test? #test:処理をスキップ
  end
end
