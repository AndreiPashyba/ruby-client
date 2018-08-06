require 'stocks_exchange_api_client'

RSpec.describe StocksExchangeApiClient do

  let(:configuration) { StocksExchangeApiClient.configure do |conf|
    conf.url = 'https://app.stocks.exchange/api2'
    conf.api_key = 'XXXXXXXXXXXXXXXXXX'
    conf.api_secret = 'XXXXXXXXXXXXXXXX'
  end }

  it 'has a version number' do
    expect(StocksExchangeApiClient::VERSION).not_to be nil
  end
end
