class HashtagsController < ApplicationController

  # GET /hashtags
  def index
    @hashtags = Hashtag.all
  end

  # GET /hashtags/1
  def show
    @hashtag = Hashtag.find(params[:id])
  end

  # GET hashtags/new
  def new
  end

  # POST /hashtags
  def create
    @hashtag = Hashtag.new(hashtag_params)

    if @hashtag.tag[0] != '#'
      @hashtag.tag = '#' + @hashtag.tag
    end

    @hashtag.save

    # Using the SearchApiService
    search = SearchApiService.new(@hashtag)
    
    if search.search_api
      search.create_tweets(@hashtag)
      redirect_to @hashtag
    else
      puts "Deu ruim"
    end
  end

  # PATCH/PUT /hashtags/1
  def update
    @hashtag = Hashtag.find(params[:id])

    Tweet.where(hashtag_id: @hashtag.id).destroy_all

    # Using the SearchApiService
    search = SearchApiService.new(@hashtag)
    
    if search.search_api
      search.create_tweets(@hashtag)
      redirect_to @hashtag
    else
      puts "Deu ruim"
    end

  end

  # DELETE /hashtags/1
  def destroy
    @hashtag = Hashtag.find(params[:id])
    @hashtag.destroy

    redirect_to hashtags_url
  end

  private

    def hashtag_params
      params.require(:hashtag).permit(:tag)
    end

end
