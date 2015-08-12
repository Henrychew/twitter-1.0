get '/' do
  erb :index
end

#FIRST : QUERY ALL THE TWEETS INTO YOUR LOCAL HOST

# get '/:username' do
#   @tweets = $client.user_timeline(params[:username])
#   erb :index
# end


#SECOND : QUERY ALL THE TWEETS FROM TWITTER SERVER IF LOCAL HOST IS EMTPY OR WHETHER THE LAST TWEET IS THE LAST TWEET


get '/:username' do
  @twitter_user = TwitterUser.find_or_create_by(username: params['username'])
  @tweets = @twitter_user.tweets

  #WHEN IS EMTPY
    if @tweets.empty?
      @tweets = $client.user_timeline(params[:username])
      @tweets.each do |tweet|
      @twitter_user.tweets.create(text: tweet.text)
    end

  #WHEN IS NOT EMTPY AND ITS VALID (TO CHECK THE LAST TWEET_DATABASE IS LAST TWEET FROM TWITTER SERVER)

  elsif @tweets.last.still_valid?
      @tweets = @twitter_user.tweets.all
  else
  #GEM DEFAULT IS 20 TWEETS

      @twitter_user.tweets.destroy_all
      @tweets = $client.user_timeline(params[:username])


      @tweets.each do |tweet|
      @twitter_user.tweets.create(text: tweet.text)
      end
    end
    erb :index
end


post '/' do
  redirect to "/#{params[:username]}"
end