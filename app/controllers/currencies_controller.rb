class CurrenciesController < ApplicationController
  require 'open-uri'
  require 'json'
 def first_currency
  @raw_data = open("https://api.exchangerate.host/symbols").read
  @parsed_data = JSON.parse(@raw_data)
  @symbols_hash = @parsed_data.fetch("symbols")

  @array_of_symbols = @symbols_hash.keys

  render({ :template => "currency_templates/step_one.html.erb" })
 end 

 def second_currency 
  @raw_data = open("https://api.exchangerate.host/symbols").read
  @parsed_data = JSON.parse(@raw_data)
  @symbols_hash = @parsed_data.fetch("symbols")

  @array_of_symbols = @symbols_hash.keys

  @from_symbol = params.fetch("from_currency")

  render({ :template => "currency_templates/step_two.html.erb" })
 end

 def convert_currency
  # {"from_currency"=>"ALL", "to_exchange"=>"AED"}
  @from_symbol = params.fetch("from_currency")
  @to_symbol = params.fetch("to_exchange")

  api_url = "https://api.exchangerate.host/convert?from=#{@from_symbol}&to=#{@to_symbol}"

  # TODO: replace USD and EUR with from_symbol and to_symbol
  @raw_data = open(api_url).read
  @parsed_data = JSON.parse(@raw_data)

  # TODO: update with the parsed_data

  #@exchange_hash = @parsed_data.fetch("convert")
  #@rate = @exchange_hash.keys

  @rate = @parsed_data.fetch("result")

  render({ :template => "currency_templates/step_three.html.erb" })
 end 
 

end
