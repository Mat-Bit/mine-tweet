require 'rest-client'
require 'json'

class ListTweetsController < ApplicationController


  def index

  end
end

base_api_url = "https://api.twitter.com/1.1/search/tweets.json"
auth = "Bearer AAAAAAAAAAAAAAAAAAAAAOsABgEAAAAAtUA16lT7ybdFpBpamME9Dp7L4X4%3DioSiudZDIQjkRZuRor1O68dI8y7RvZTrhBlHSciNea9lOODsWH"

q = "#freehongkong"

url = base_api_url + "?q=%23" + q[1..q.length]

# url2 = base_api_url + "?q=" + q.force_encoding(Encoding::UTF_8)
# print url2

puts url
puts

resp = RestClient.get(url, {accept: :json, authorization: auth})

parsed_resp = JSON.parse(resp)

parsed_resp["statuses"].each do |tweet|
    puts "Texto:", tweet["text"]
    puts "Data post:", tweet["created_at"]
    puts "User:", tweet["user"]["screen_name"]
    puts
end
