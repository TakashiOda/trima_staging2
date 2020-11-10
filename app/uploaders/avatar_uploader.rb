class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  # S3にアップロードする場合
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # デフォルト画像は700x700に収まるようリサイズ
  process :resize_to_fill => [300, 300, gravity = ::Magick::CenterGravity]

  # サムネイル画像
  version :thumb do
     process resize_to_fill: [100, 100]
  end

  # 許可する画像の拡張子
  def extension_whitelist
     %w(jpg jpeg gif png)
  end

  # 保存するファイルの命名規則
  def filename
    if original_filename
      "#{original_filename}.jpg"
    else
     "avatar_#{model.class.to_s.underscore}_#{model.id}.jpg"
    end
  end

  protected
  # 一意となるトークンを作成
  def secure_token
     var = :"@#{mounted_as}_secure_token"
     model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
