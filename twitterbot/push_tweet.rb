class PushTweet
  @queue = :tweets_queue
  def self.perform(tweet)
    puts "Found tweet: #{tweet["text"]}"
  end
end