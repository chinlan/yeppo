class User < ActiveRecord::Base

  include Gravtastic
  gravtastic

  scope :publicing, -> {where(:status => "公開")}
  
  has_many :comments
  has_many :shots

  has_many :likes, :dependent => :destroy
  has_many :like_shots, :through => :likes, :source => :shot

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable, :omniauth_providers => [:facebook]

  has_attached_file :head, styles: { medium: '70x70>', thumb: '25x25>' },
                             url: '/system/:class/:attachment/:id_partition/:style/:hash.:extension',
                             path: ':rails_root/public/system/:class/:attachment/:id_partition/:style/:hash.:extension',
                             hash_secret: 'get_from_rake_secret'
  validates_attachment :head, content_type: { content_type: /\Aimage\/.*\Z/ },
                                size: { in: 0..1.megabytes }

  def self.from_omniauth(auth)
     where( fb_uid: auth.uid).first_or_create do |user|
       user.email = auth.info.email
       user.password = Devise.friendly_token[0,20]
       user.name = auth.info.name   # assuming the user model has a name
     end
  end  

  def admin?
    self.role == "admin"
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end
  
  
end
