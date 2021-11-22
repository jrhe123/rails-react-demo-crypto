class Currency < ApplicationRecord

  def current_price
    url = 'https://pro-api.coinmarketcap.com/v2/tools/price-conversion'
    query = { 
      "symbol"     => self.currency_symbol,
      "amount"      => 1,
    }
    headers = { 
      "X-CMC_PRO_API_KEY"  => "YOUR_API_KEY",
    }
    request = HTTParty.get(
      url, 
      :query => query,
      :headers => headers
    )
    response = JSON.parse(request.body)['data'][0]['quote']['USD']['price'] || '0'
  end

  def calculate_value(amount)
    (current_price.to_f * amount.to_f).round(4)
  end
end
