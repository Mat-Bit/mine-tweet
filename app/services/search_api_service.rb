class SearchApiService

  def initialize(params)
    @query = params[:tag]
  end


  def search_api
    begin
      base_api_url = "https://api.twitter.com/1.1/search/tweets.json"
      auth = "Bearer AAAAAAAAAAAAAAAAAAAAAOsABgEAAAAAtUA16lT7ybdFpBpamME9Dp7L4X4%3DioSiudZDIQjkRZuRor1O68dI8y7RvZTrhBlHSciNea9lOODsWH"

      url = base_api_url + "?q=%23" + @query[1..@query.length]

      resp = RestClient.get(url, {accept: :json, authorization: auth})

      @parsed_resp = JSON.parse(resp)
    rescue
      false
    end
  end

  def create_tweets(params)
    @parsed_resp["statuses"].each do |tw|

      puts "Hashtag:", @query
      puts "User name:", tw["user"]["name"]
      puts "Mensagem:", tw["text"]
      puts

      @tweet = params.tweets.new(
        # hash_id: params[:id],
        tweet_desc: tw["text"],
        date_post: tw["created_at"],
        user_name: tw["user"]["name"],
        user_screen_name: tw["user"]["screen_name"],
        url_img_user: tw["user"]["profile_image_url"]
      ).save
    end
  end

end