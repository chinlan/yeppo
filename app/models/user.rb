class User < ActiveRecord::Base
  
  has_many :comments
  has_many :shots

  has_many :likes, :dependent => :destroy
  has_many :like_shots, :through => :likes, :source => :shot
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
     where( fb_uid: auth.uid).first_or_create do |user|
       user.email = auth.info.email
       user.password = Devise.friendly_token[0,20]
       user.name = auth.info.name   # assuming the user model has a name
     end
  end  
       
end
