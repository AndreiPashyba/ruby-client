module StocksExchangeApiClient
  class Public
    class << self
      def currencies
        StocksExchangeApiClient.make_api_request(:get,
                                                 nil,
                                                 'currencies')
      end

      def markets
        StocksExchangeApiClient.make_api_request(:get,
                                                 nil,
                                                 'markets')
      end

      def markets_summary(currency1 = 'ETH', currency2 = 'BTC')
        url = "market_summary/#{currency1}/#{currency2}"
        StocksExchangeApiClient.make_api_request(:get,
                                                 nil,
                                                 url)
      end

      def ticker
        StocksExchangeApiClient.make_api_request(:get,
                                                 nil,
                                                 'ticker')
      end

      def prices
        StocksExchangeApiClient.make_api_request(:get,
                                                 nil,
                                                 'prices')
      end

      def trade_history(pair = DEFAULT_PAIRS)
        url = "trades?pair=#{pair}"
        StocksExchangeApiClient.make_api_request(:get,
                                                 nil,
                                                 url)
      end

      def order_book(pair = DEFAULT_PAIRS)
        url = "orderbook?pair=#{pair}"
        StocksExchangeApiClient.make_api_request(:get,
                                                 nil,
                                                 url)
      end

      def grafic(params = {})
        params[:pair] = params[:pair].nil? ? DEFAULT_PAIRS : params[:pair]
        params[:count] = params[:count].nil? ? MAX_COUNT : params[:count]
        params[:order] = params[:order].nil? ? ASC : params[:order]
        params[:interval] = params[:interval].nil? ? INTERVAL[:day] : params[:interval]
        params[:page] = params[:page].nil? ? 1 : params[:page]
        params[:order] = ASC unless params[:since].nil? || params[:end].nil?
        encode_www_form = URI.encode_www_form(params)

        url = "grafic_public?#{encode_www_form}"
        StocksExchangeApiClient.make_api_request(:get,
                                                 nil,
                                                 url)
      end
    end
  end
end
