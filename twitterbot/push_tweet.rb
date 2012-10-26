class PushTweet
  @queue = :tweets_queue
  def self.perform(tweet)
  	#p tweet
    puts "PROCESSING "  + tweet['status']
  end
end