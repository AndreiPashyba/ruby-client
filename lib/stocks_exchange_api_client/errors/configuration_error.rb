module StocksExchangeApiClient
  module Errors
    class ConfigurationError < StandardError
      def initialize
        super 'Not all config vars were set. Stocks Exchange requires API key and API secret. Get this fields on url https://app.stocks.exchange/en/profile/settings'
      end
    end
  end
end