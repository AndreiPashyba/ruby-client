require 'openssl'
require 'httparty'
require 'json'
require 'ostruct'


# Version
require 'stocks_exchange_api_client/version'

# Private API method
require 'stocks_exchange_api_client/private'

# Public API method
require 'stocks_exchange_api_client/public'

# Configuration
require 'stocks_exchange_api_client/configuration'


module StocksExchangeApiClient

  METHOD_NAME = {
      get_info: 'GetInfo',
      active_orders: 'ActiveOrders',
      trade: 'Trade',
      cancel_order: 'CancelOrder',
      trade_history: 'TradeHistory',
      trade_register_history: 'TradeRegisterHistory',
      user_history: 'UserHistory',
      trans_history: 'TransHistory',
      grafic: 'Grafic',
      generate_wallets: 'GenerateWallets',
      deposit: 'Deposit',
      withdraw: 'Withdraw'
  }.freeze

  HEX_ALGORITHM = 'sha512'

  class << self

    def configure
      yield(configuration)
    end

    def make_api_request(method = :post, params = {}, type)
      configuration.validate!
      if method == :post
        params.merge!({method: type, nonce: Time.now.to_i})
        encode_www_form = URI.encode_www_form(params)
        sign = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new(HEX_ALGORITHM), configuration.api_secret, encode_www_form)
        response = JSON.parse(
            HTTParty.post(configuration.url, body: params, headers: {
                :Sign => sign,
                :Key => configuration.api_key
            }).body)
        response =  OpenStruct.new(response)
      end
      if method == :get
        response =  JSON.parse(HTTParty.get("#{configuration.url}/#{type}").body)
      end
      response
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end
end