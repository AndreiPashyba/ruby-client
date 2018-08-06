module StocksExchangeApiClient
  ASC = 'ASC'.freeze

  ALL = 'ALL'.freeze

  MAX_COUNT = 50

  STATUS_ORDER = {
    pending: 1,
    processing: 2,
    finished: 3,
    canceled: 4
  }.freeze

  STATUS_ORDER_HUMAN_NAME = {
    1 => 'PENDING',
    2 => 'PROCESSING',
    3 => 'FINISHED',
    4 => 'CANCELED'
  }.freeze

  OWNER = {
    all: 'ALL',
    own: 'OWN'
  }.freeze

  INTERVAL = {
    day: '1D',
    month: '1M',
    three_month: '3M',
    year: '1Y'
  }.freeze

  DEFAULT_PAIRS = 'ETH_BTC'.freeze

  class Private
    class << self
      def get_info
        StocksExchangeApiClient.make_api_request(:post,
                                                 {},
                                                 METHOD_NAME[:get_info])
      end

      def active_order(params = {})
        params[:pair] = params[:pair].nil? ? ALL : params[:pair]
        params[:count] = params[:count].nil? ? MAX_COUNT : params[:count]
        params[:order] = params[:order].nil? ? ASC : params[:order]
        params[:type] = params[:type].nil? ? ALL : params[:type]
        params[:owner] = params[:owner].nil? ? ALL : params[:owner]

        params[:order] = ASC unless params[:since].nil? || params[:end].nil?

        StocksExchangeApiClient.make_api_request(:post,
                                                 params,
                                                 METHOD_NAME[:active_orders])
      end

      def trade(type = nil, pair = nil, amount = nil, rate = nil)
        params = {
          type: type,
          pair: pair,
          amount: amount,
          rate: rate
        }
        StocksExchangeApiClient.make_api_request(:post,
                                                 params,
                                                 METHOD_NAME[:trade])
      end

      def cancel_order(order_id)
        params = { order_id: order_id }
        StocksExchangeApiClient.make_api_request(:post,
                                                 params,
                                                 METHOD_NAME[:cancel_order])
      end

      def trade_history(params = {})
        params[:pair] = params[:pair].nil? ? ALL : params[:pair]
        params[:count] = params[:count].nil? ? MAX_COUNT : params[:count]
        params[:order] = params[:order].nil? ? ASC : params[:order]
        params[:owner] = params[:owner].nil? ? OWNER[:own] : params[:owner]
        params[:status] = params[:status].nil? ? STATUS_ORDER[:finished] : params[:status]
        params[:order] = ASC unless params[:since].nil? || params[:end].nil?

        StocksExchangeApiClient.make_api_request(:post,
                                                 params,
                                                 METHOD_NAME[:trade_history])
      end

      def trade_register_history(params = {})
        params[:currency] = params[:currency].nil? ? ALL : params[:currency]

        StocksExchangeApiClient.make_api_request(:post,
                                                 params,
                                                 METHOD_NAME[:trade_register_history])
      end

      def user_history(params = {})
        StocksExchangeApiClient.make_api_request(:post,
                                                 params,
                                                 METHOD_NAME[:user_history])
      end

      def trans_history(params = {})
        params[:currency] = params[:currency].nil? ? ALL : params[:currency]
        params[:count] = params[:count].nil? ? MAX_COUNT : params[:count]
        params[:order] = params[:order].nil? ? 'DESC' : params[:order]
        params[:operation] = params[:operation].nil? ? ALL : params[:operation]
        params[:status] = params[:status].nil? ? STATUS_ORDER_HUMAN_NAME[STATUS_ORDER[:finished]] : params[:status]
        params[:order] = ASC unless params[:since].nil? || params[:end].nil?

        params[:status] = STATUS_ORDER_HUMAN_NAME[STATUS_ORDER[:finished]] unless params[:operation].nil? && params[:operation] == ALL

        StocksExchangeApiClient.make_api_request(:post,
                                                 params,
                                                 METHOD_NAME[:trans_history])
      end

      def grafic(params = {})
        params[:pair] = params[:pair].nil? ? DEFAULT_PAIRS : params[:pair]
        params[:count] = params[:count].nil? ? MAX_COUNT : params[:count]
        params[:order] = params[:order].nil? ? ASC : params[:order]
        params[:interval] = params[:interval].nil? ? INTERVAL[:day] : params[:interval]
        params[:page] = params[:page].nil? ? 1 : params[:page]
        params[:order] = ASC unless params[:since].nil? || params[:end].nil?

        StocksExchangeApiClient.make_api_request(:post,
                                                 params,
                                                 METHOD_NAME[:grafic])
      end

      def generate_wallets(currency)
        StocksExchangeApiClient.make_api_request(:post,
                                                 { currency: currency },
                                                 METHOD_NAME[:generate_wallets])
      end

      def deposit(currency)
        StocksExchangeApiClient.make_api_request(:post,
                                                 { currency: currency },
                                                 METHOD_NAME[:deposit])
      end

      def withdraw(currency, address, amount)
        params = {
          currency: currency,
          address: address,
          amount: amount
        }

        StocksExchangeApiClient.make_api_request(:post,
                                                 params,
                                                 METHOD_NAME[:withdraw])
      end
    end
  end
end
