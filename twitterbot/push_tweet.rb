class PushTweet
  @queue = :tweets_queue
  def self.perform(tweet)
    puts "PROCESSING "  + tweet['status']
  	p tweet
  end
end