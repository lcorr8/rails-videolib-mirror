class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:github]


  def self.from_omniauth(auth)
      where(email: auth.info.email).first_or_create do |user|
      user.uid = auth.uid
      user.provider = auth.provider
      #use the github username to link to learn.co profiles
      user.username = auth.info.nickname
      #add image to show the github/learn avatar
      #user.image_link = auth.info.image
      user.password = SecureRandom.hex
    end      
  end


end