class MainImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

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


  # 許可する画像の拡張子
  def extension_whitelist
     %w(jpg jpeg gif png)
  end

  def size_range
    0..2.megabytes
  end


  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # 保存するファイルの命名規則
  def filename
     "main_image.jpg" if original_filename
  end

  protected
  # 一意となるトークンを作成
  def secure_token
     var = :"@#{mounted_as}_secure_token"
     model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
