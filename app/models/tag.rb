class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :shots, :through => :taggings
end
