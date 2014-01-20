require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class MercadoLibre < OmniAuth::Strategies::OAuth2
      API_ROOT_URL  = ENV["MERCADOLIBRE_API_ROOT_URL" ] || "https://api.mercadolibre.com"
      AUTH_URL      = ENV["MERCADOLIBRE_AUTH_URL"     ] || "https://auth.mercadolibre.com/authorization"
      OAUTH_URL     = ENV["MERCADOLIBRE_OAUTH_URL"    ] || "https://api.mercadolibre.com/oauth/token"

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
          %w[scope client_options].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end
        end
      end

      uid { raw_info['client_id'].to_s }

      info do
       { raw_info: raw_info }
      end

      extra do
        { raw_info: raw_info }
      end


    end
  end
end

OmniAuth.config.add_camelization 'mercadolibre', 'MercadoLibre'
