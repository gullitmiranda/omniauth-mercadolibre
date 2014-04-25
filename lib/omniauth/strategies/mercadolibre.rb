require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class MercadoLibre < OmniAuth::Strategies::OAuth2
      # API_ROOT_URL  = ENV["MERCADOLIBRE_API_ROOT_URL" ] || "https://api.mercadolibre.com"
      # AUTH_URL      = ENV["MERCADOLIBRE_AUTH_URL"     ] || "https://auth.mercadolibre.com/authorization"
      # OAUTH_URL     = ENV["MERCADOLIBRE_OAUTH_URL"    ] || "https://api.mercadolibre.com/oauth/token"

      API_ROOT_URL  = ENV["MERCADOLIBRE_API_ROOT_URL" ] || "https://api.mercadolibre.com"
      AUTH_URL      = ENV["MERCADOLIBRE_AUTH_URL"     ] || "http://auth.mercadolivre.com.br/authorization"
      OAUTH_URL     = ENV["MERCADOLIBRE_OAUTH_URL"    ] || "/oauth/token"

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
          params[:response_type] = "code"
          params[:client_id] = client.id
          params[:redirect_uri] ||= callback_url
        end
      end

      def build_access_token
        token_params = {
          :code => request.params['code'],
          :redirect_uri => callback_url,
          :client_id => client.id,
          :client_secret => client.secret,
          :grant_type => 'authorization_code'
        }
        client.get_token(token_params)
      end

      # data response of api
      uid { raw_info['id'].to_s }

      info do
        prune!({
          username:   raw_info['nickname'],
          email:      raw_info['email'],
          first_name: raw_info['first_name'],
          last_name:  raw_info['last_name'],
          image:      raw_info['logo'],
          url:        raw_info['permalink']
        })
      end

      extra do
        hash = {}
        hash[:access_token] = access_token.to_hash
        hash[:raw_info] = raw_info unless skip_info?
        prune! hash
      end

      def raw_info
        @raw_info ||= access_token.get("users/me", params_token).parsed
      end

      def params_token
         { params: access_token.to_hash }
      end

      private

      def prune!(hash)
        hash.delete_if do |_, v|
          prune!(v) if v.is_a?(Hash)
          v.nil? || (v.respond_to?(:empty?) && v.empty?)
        end
      end
    end
  end
end

OmniAuth.config.add_camelization 'mercadolibre', 'MercadoLibre'
