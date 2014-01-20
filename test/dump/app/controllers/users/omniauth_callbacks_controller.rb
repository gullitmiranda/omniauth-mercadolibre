class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def mercadolibre
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_mercadolibre_oauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "MercadoLibre") if is_navigational_format?
    else
      session["devise.mercadolibre_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
