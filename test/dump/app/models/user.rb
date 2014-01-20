class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and
  devise :database_authenticatable, :omniauthable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  class << self
    def find_for_mercadolibre_oauth(auth)
      user = User.where(:provider => auth.provider, :uid => auth.uid).first

      Rails.logger.debug "\n #MercadoLibreResponse= #{auth.to_json} \n"


      # unless user
      #   user = User.create!(firstname:  auth.info.first_name,
      #                       lastname:   auth.info.last_name,
      #                       username:   auth.info.nickname,
      #                       provider:   auth.provider,
      #                       uid:        auth.uid,
      #                       email:      auth.info.email,
      #                       password:   Devise.friendly_token[0,20],
      #                       remote_avatar_url: "https://graph.facebook.com/#{auth.uid}/picture?type=large&width=256")
      # end

      user
    end

    def new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.mercadolibre_data"] && session["devise.mercadolibre_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end
  end
end
