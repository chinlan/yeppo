class Shot < ActiveRecord::Base
  validates_presence_of :photo
  belongs_to :user
  has_many :comments, :dependent => :destroy

  has_many :likes, :dependent => :destroy
  has_many :like_users, :through => :likes, :source => :user

 has_attached_file :photo, styles: { medium: '300x300>', thumb: '100x100>' },
                             url: '/system/:class/:attachment/:id_partition/:style/:hash.:extension',
                             path: ':rails_root/public/system/:class/:attachment/:id_partition/:style/:hash.:extension',
                             hash_secret: 'get_from_rake_secret'
  validates_attachment :photo, content_type: { content_type: /\Aimage\/.*\Z/ },
                                size: { in: 0..1.megabytes }
end
