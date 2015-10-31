class User < ActiveRecord::Base
  
  STATUS = ["hide", "public"]

  include Gravtastic
  gravtastic

  scope :publicing, -> {where(:status => "public")}
  
  has_many :comments, :dependent => :destroy
  has_many :shots, :dependent => :destroy

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

  has_attached_file :head, styles: { medium: '200x200>', thumb: '25x25>' },
                             url: '/system/:class/:attachment/:id_partition/:style/:hash.:extension',
                             path: ':rails_root/public/system/:class/:attachment/:id_partition/:style/:hash.:extension',
                             hash_secret: 'get_from_rake_secret'
  validates_attachment :head, content_type: { content_type: /\Aimage\/.*\Z/ },
                                size: { in: 0..1.megabytes }
  
  # validates_presence_of :friendly_id
  # validates_uniqueness_of :friendly_id
  # validates_format_of :friendly_id, :with => /\A[a-z0-9\-]+\z/,
  #                     :message => "請用英數字"

  before_create :generate_authentication_token

  def public?
    self.status == "public"
  end

  # def self.from_omniauth(auth)
  #    where( fb_uid: auth.uid).first_or_create do |user|
  #      user.email = auth.info.email
  #      # user.image =　auth.info.image
  #      user.password = Devise.friendly_token[0,20]
  #      user.name = auth.info.name   # assuming the user model has a name
  #    end
  # end  
  
  def self.from_omniauth(auth)
   # Case 1: Find existing user by facebook uid
   user = User.find_by_fb_uid( auth.uid )
   if user
      user.fb_token = auth.credentials.token
   #   user.fb_raw_data = auth
      user.save!
     return user
   end

   # Case 2: Find existing user by email
   existing_user = User.find_by_email( auth.info.email )
   if existing_user
     existing_user.fb_uid = auth.uid
     existing_user.fb_token = auth.credentials.token
     #existing_user.fb_raw_data = auth
     existing_user.save!
     return existing_user
   end

   # Case 3: Create new password
   user = User.new
   user.fb_uid = auth.uid
   user.fb_token = auth.credentials.token
   user.email = auth.info.email
   user.name = auth.info.name 
   user.head =　auth.info.image
   user.password = Devise.friendly_token[0,20]
   #user.fb_raw_data = auth
   user.save!
   return user
 end

  def self.get_fb_data(access_token)
    res = RestClient.get "https://graph.facebook.com/v2.4/me",  { :params => { :access_token => access_token } }

    if res.code == 200
      JSON.parse( res.to_str )
    else
      Rails.logger.warn(res.body)
      nil
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

  def generate_authentication_token
   self.authentication_token = Devise.friendly_token
 end
  
   # def to_param
   #  self.friendly_id
   # end
end
