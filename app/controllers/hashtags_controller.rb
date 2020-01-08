class HashtagsController < ApplicationController

  def new
    
  end

  def index
    @hashtags = Hashtag.order :created_at
  end

end
