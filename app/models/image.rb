class Image < ActiveRecord::Base
  belongs_to :fraud

  mount_uploader :image, ImageUploader
end