# require twurl
require 'json'

# class ListTweetsController < ApplicationController
#   # include twurl

#   base_api_url = "/1.1/search/tweets.json"

#   hashtag = ""
#   count = 100

  
#   def index

#   end
# end

arq_json = File.read("../../db/freehk.json")

parsed_freehk = JSON.parse(arq_json)

stat_one = parsed_freehk["statuses"][0]

text = stat_one["text"]
date_post = stat_one["created_at"]
user = stat_one["user"]["screen_name"]


print text
print "\n"
print date_post
print "\n"
print user
print "\n"

