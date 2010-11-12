class Image < ActiveRecord::Base
  attr_accessible :title, :avatar
  mount_uploader :avatar, AvatarUploader
end
