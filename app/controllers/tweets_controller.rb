require 'rest-client'
require 'json'

class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /tweets
  # GET /tweets.json
  def index
    @tweets = Tweet.order :created_at
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets_search
  def search
    q = params["hashtag"]

    base_api_url = "https://api.twitter.com/1.1/search/tweets.json"
    auth = "Bearer AAAAAAAAAAAAAAAAAAAAAOsABgEAAAAAtUA16lT7ybdFpBpamME9Dp7L4X4%3DioSiudZDIQjkRZuRor1O68dI8y7RvZTrhBlHSciNea9lOODsWH"

    url = base_api_url + "?q=%23" + q[1..q.length]

    puts url
    puts

    resp = RestClient.get(url, {accept: :json, authorization: auth})

    parsed_resp = JSON.parse(resp)

    parsed_resp["statuses"].each do |tw|

      puts "Texto:", tw["text"]
      puts "Data post:", tw["created_at"]
      puts "User:", tw["user"]["screen_name"]
      puts

      @tweet = Tweet.create(
        i_tweet: tw["id_str"],
        tweet_desc: tw["text"],
        date_post: tw["created_at"],
        user_name: tw["user"]["name"],
        user_screen_name: tw["user"]["screen_name"]
      )

    end

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end

  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = Tweet.new(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.fetch(:tweet, {})
    end
end
