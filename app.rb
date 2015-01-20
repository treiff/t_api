class App < Sinatra::Base

  set :server, 'webrick'

  SITE_TITLE = "Tweet Data"

  CLIENT = Twitter::REST::Client.new do |config|
    config.consumer_key             = ENV["CONSUMER_KEY"]
    config.consumer_secret          = ENV["CONSUMER_SECRET"]
    config.bearer_token             = ENV["BEARER_TOKEN"]
  end

  get '/' do
    @title = "Home"
    erb :index
  end

  get '/results' do
    @title = "User Results"
    @tag = params[:tag]
    @timeline = CLIENT.user_timeline(@tag, :count => 200, :exclude_replies => true)
    @id = CLIENT.user(@tag).id
    @timezone = CLIENT.user(@tag).time_zone
    erb :results
  end

  get '/georesults' do
    @title = "Geo Results"
    @tag = params[:tag]
    @location = params[:location]
    @radius = params[:radius]
    @tweets = CLIENT.search(@tag, :count => 1, :lang => 'en', :geocode => location)
    erb :georesults
  end

  helpers do

    # Pass @location to geocoder, return lat,long,radius string for twitter api
    def location
      @geocoded_location = Geocoder.coordinates(@location)
      latitude = @geocoded_location[0].to_s
      longitude = @geocoded_location[1].to_s
      return "#{latitude.to_s},#{longitude.to_s},#{@radius.to_s}mi"
    end

    # Group tweets by day of the week.
    def tweet_day(array)
      day = {}
      array.each do |tweet|
        if day.has_key?(tweet.created_at.strftime("%a"))
          day[tweet.created_at.strftime("%a")] += 1
        else
          day[tweet.created_at.strftime("%a")] = 1
        end
      end
      day
    end

    # Group tweets by times of tweet.
    def tweet_time(array)
      time = {}
      array.each do |tweet|
        if time.has_key?(tweet.created_at.hour)
          time[tweet.created_at.hour] += 1
        else
          time[tweet.created_at.hour] = 1
        end
      end
      time
    end

    def get_user_history
      HTTParty.get("http://api.twittercounter.com/?apikey=#{ENV["TC_KEY"]}&twitter_id=#{@id}")
    end

    # Clean text from infront of date returned by get_user_histroy
    def scrub_date(hash)
      scrubbed_hash = {}
      hash.each do |key, value|
        scrubbed_hash[key.gsub(/[a-z]/, '')] = value
      end
      scrubbed_hash
    end
  end
end
