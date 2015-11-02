class Shot < ActiveRecord::Base

  TYPES = ["photographer", "model"]

  validates_presence_of :photo, :shot_type
  belongs_to :user
  has_many :comments, :dependent => :destroy

  belongs_to :tag_user, :class_name => "User", :foreign_key => "tag_user_id"

  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings

  has_many :likes, :dependent => :destroy
  has_many :like_users, :through => :likes, :source => :user

  has_attached_file :photo, styles: { large: '1200x1200>', medium: '300x300>', thumb: '100x100>' },
                             url: '/system/:class/:attachment/:id_partition/:style/:hash.:extension',
                             path: ':rails_root/public/system/:class/:attachment/:id_partition/:style/:hash.:extension',
                             hash_secret: 'get_from_rake_secret'
                    :attachment, :storage => :s3, :s3_credentials => "#{Rails.root}/config/s3.yml", :s3_host_name => "s3-ap-northeast-1.amazonaws.com"
  validates_attachment :photo, content_type: { content_type: /\Aimage\/.*\Z/ },
                                size: { in: 0..1.megabytes }

  scope :only_model, -> { where( :shot_type => "model") }
  scope :only_photographer, -> { where( :shot_type => "photographer") }

  scope :publicing, -> { joins(:user).where( "users.status"  => "public"  ) }                              
  
  def photographer?
    shot_type == "photographer"
  end

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
    self.joins(:taggings=>[:tag]).where("tags.name=?",name)
    # Tag.find_by_name!(name).shots
  end

end
