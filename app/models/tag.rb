class Tag < ActiveRecord::Base
  has_many :taggings, :dependent => :destroy
  has_many :shots, :through => :taggings
end
