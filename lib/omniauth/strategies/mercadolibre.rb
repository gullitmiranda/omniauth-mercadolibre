require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class MercadoLibre < OmniAuth::Strategies::OAuth2
      API_ROOT_URL  = ENV["MERCADOLIBRE_API_ROOT_URL" ] || "https://api.mercadolibre.com"
      AUTH_URL      = ENV["MERCADOLIBRE_AUTH_URL"     ] || "https://auth.mercadolibre.com/authorization"
      OAUTH_URL     = ENV["MERCADOLIBRE_OAUTH_URL"    ] || "https://api.mercadolibre.com/oauth/token"

      DEFAULT_SCOPE = "items,payments,questions,orders"

      option :authorize_options, [:access_type, :hd, :login_hint, :prompt, :request_visible_actions, :scope, :state, :redirect_uri]

      option :client_options, {
        site: API_ROOT_URL,
        authorize_url: AUTH_URL,
        token_url: OAUTH_URL
      }

      def request_phase
        super
      end

      def authorize_params
        super.tap do |params|
        Rails.logger.debug " \n\n\ ---- authorize_params params= #{params}"

          # %w[scope client_options].each do |v|
          #   if request.params[v]
          #     params[v.to_sym] = request.params[v]
          #   end
          # end

          options[:authorize_options].each do |k|
            params[k] = request.params[k.to_s] unless [nil, ''].include?(request.params[k.to_s])
          end

          raw_scope = params[:scope] || DEFAULT_SCOPE
          scope_list = raw_scope.split(" ").map {|item| item.split(",")}.flatten
          scope_list.map! { |s| s =~ /^https?:\/\// ? s : "#{API_ROOT_URL}/#{s}" }
          params[:scope] = scope_list.join(" ")
          params[:access_type] = 'offline' if params[:access_type].nil?

        Rails.logger.debug " \n\n\ ---- authorize_params params= #{params}"

          session['omniauth.state'] = params[:state] if params['state']
        end
      end

      uid { raw_info['client_id'].to_s }

      info do
       { raw_info: raw_info }
      end

      extra do
        { raw_info: raw_info }
      end

      def callback_phase
        Rails.logger.debug " \n\n\ ---- callback_phase params= #{request.params}"
        Rails.logger.debug " \n\n\ ---- callback_phase env['omniauth.auth']= #{env}"
        # https://api.mercadolibre.com/oauth/token?grant_type=authorization_code&client_id=CLIENT_ID&client_secret=CLIENT_SECRET&code=SECRET_CODE&redirect_uri=$APP_CALLBACK_URL
        # @auth_token = get_auth_token(request.params["username"], request.params["sid"])
        # @user_info = get_user_info(request.params["username"], @auth_token)
        super
      # rescue => ex
      #   fail!("Failed to retrieve user info from ebay", ex)
      end

      def raw_info
        # @raw_info ||= access_token.get('https://www.googleapis.com/oauth2/v1/userinfo').parsed
        Rails.logger.debug " \n\n\ ---- request.params= #{request.params}"
        Rails.logger.debug " \n\n\ ---- access_token= #{access_token.to_json}"

        # Rails.logger.debug " \n\n\ ---- access_token.inspect= #{access_token.inspect}"
        # Rails.logger.debug " \n\n\ ---- request.params.inspect= #{request.params.inspect}"

        # Rails.logger.debug " \n\n----\n\n "

        # Rails.logger.debug " \n\n\ ---- get('user')= #{access_token.get('users/me').parsed}"
        Rails.logger.debug " \n\n\ ---- get('user')= #{access_token.get('https://api.mercadolibre.com/users/me').parsed}"

        # @raw_info ||= access_token.get('users/me').parsed
        @raw_info ||= access_token.get('users/me').parsed
      end

      def custom_build_access_token
        ret = if verify_token(request.params['id_token'], request.params['access_token'])
          ::OAuth2::AccessToken.from_hash(client, request.params.dup)
        else
          orig_build_access_token
        end
      end
      alias_method :orig_build_access_token, :build_access_token
      alias :build_access_token :custom_build_access_token

      def verify_token(id_token, access_token)
        Rails.logger.debug " \n\n\ ---- verify #{id_token} #{access_token}"

        return false unless (id_token && access_token)

        raw_response = client.request(:get, OAUTH_URL, :params => {
          :id_token => id_token,
          :access_token => access_token
        }).parsed
        raw_response['issued_to'] == options.client_id
      end
    end
  end
end

OmniAuth.config.add_camelization 'mercadolibre', 'MercadoLibre'
