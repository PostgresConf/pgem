# encoding: utf-8

class AttachmentUploader < CarrierWave::Uploader::Base
  include CarrierWave::Compatibility::Paperclip

  # use cloudinary if it's configured
  if Cloudinary.config.cloud_name
    # use https by default
    Cloudinary.config.secure = true

    include Cloudinary::CarrierWave

    def public_id
      model.try(:file_name)
    end
  end

  def paperclip_path
    "system/#{object_class_name}/#{extra_store_dir}/#{id_partition}/:basename.:extension"
  end

  def object_class_name
    model.class.to_s.underscore.pluralize
  end

  # compatibility with our paperclip storage paths..
  def extra_store_dir
    mounted_as
  end

  # Returns the id of the instance in a split path form. e.g. returns
  # 000/001/234 for an id of 1234. Stolen from paperclip...
  def id_partition
    ('%09d'.freeze % model.id).scan(/\d{3}/).join('/'.freeze)
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "system/#{object_class_name}/#{mounted_as}/#{model.id}"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(pdf doc docx png jpg gif ppt pptx odp odt svg ai)
  end

end
