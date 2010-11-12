class Image < ActiveRecord::Base
  attr_accessible :title, :avatar
  
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "60x60>" }
end
