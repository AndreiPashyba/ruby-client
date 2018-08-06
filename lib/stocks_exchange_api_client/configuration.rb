module StocksExchangeApiClient

  class Configuration

    URL = 'https://app.stocks.exchange/api2'

    attr_accessor :url, :api_key, :api_secret

    def initialize
      @url ||= URL
    end

    def validate!
      raise Errors::ConfigurationError unless api_key && api_secret
    end
  end

end
