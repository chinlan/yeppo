class Shot < ActiveRecord::Base
  validates_presence_of :photo, :category_id
  belongs_to :user
  has_many :comments, :dependent => :destroy

  belongs_to :category

  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings

  has_many :likes, :dependent => :destroy
  has_many :like_users, :through => :likes, :source => :user

  has_attached_file :photo, styles: { medium: '300x300>', thumb: '100x100>' },
                             url: '/system/:class/:attachment/:id_partition/:style/:hash.:extension',
                             path: ':rails_root/public/system/:class/:attachment/:id_partition/:style/:hash.:extension',
                             hash_secret: 'get_from_rake_secret'
  validates_attachment :photo, content_type: { content_type: /\Aimage\/.*\Z/ },
                                size: { in: 0..1.megabytes }

  def tag_list
    self.tags.map{ |t| t.name }.join(",")
  end

  def tag_list=(str)
    arr = str.split(",")

    self.tags = arr.map do |t|
      tag = Tag.find_by_name(t)
      unless tag
        tag = Tag.create!(:name => t)
      end
      tag
    end
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).shots
  end

end
