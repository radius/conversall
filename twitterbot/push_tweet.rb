class PushTweet
  @queue = :tweets_queue
  def self.perform(tweet)
    puts "PROCESSING "  + tweet['status']
    p tweet

    hashtags = tweet['hashtags'] || []
    puts hashtags
    hashtags.each do |h|
      t = Trigger.find_by_hashtag(h)
      puts "TRIGGER: #{t}"
      if t
        m = t.messages.sample #pick random message
        puts "MESSAGE: #{m}"
        if m
          ccode = t.coupon_codes.first
          if ccode
            code = ccode.value
            handle = tweet['handle']
            msg = m.body.gsub("{code}", "@#{handle} #{code}")
            puts "SENDING: #{msg}"

            twacct = t.campaign.twitter_account
            client = Twitter::Client.new(
                :consumer_key       => '1SlFlzJzjwFb8Hu0Xg7gQ',
                :consumer_secret    => 'd98spifmqqD4PDC9A228jH6qfNDNmxPrhaM7eEdR7A8',
                :oauth_token        => '5939272-q771BC0UaTMTKUICrBRn5ueJOwvxvuENox1YyEqoyM',
                :oauth_token_secret => 'CzZYGuU1xwOROkYT8X2v3rlpLjaNZFJHRFjQDXQp5w',
                :auth_method        => :oauth
                #:consumer_key => twacct.consumer_key,
                #:consumer_secret => twacct.consumer_secret,
                #:oauth_token => twacct.access_token,
                #:oauth_token_secret => twacct.access_token_secret,
            )
            puts "TWEET: " + client.update(msg).inspect
            puts "msg sent"
          end
        end
      end
    end
  end
end