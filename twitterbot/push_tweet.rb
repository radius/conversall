class PushTweet
  @queue = :tweets_queue
  def self.perform(tweet)
    puts "PROCESSING "  + tweet['status']
    p tweet

    hashtags = tweet['hashtags'] || []
    hashtags.each do |h|
      t = Trigger.find_by_hashtag(h)
      if t
        m = t.messages.sample #pick random message
        if m
          link = "http://test.com/test"
          handle = tweet['handle']
          msg = m.body.gsub("{code}", "@#{handle} #{link}")

          twacct = t.campaign.twitter_account
          client = Twitter::Client.new(
              :consumer_key => twacct.consumer_key,
              :consumer_secret => twacct.consumer_secret,
              :oauth_token => twacct.access_token,
              :oauth_token_secret => twacct.access_token_secret,
          )
          client.update(msg)
        end
      end
    end
  end
end