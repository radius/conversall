require "rubygems"
require "bundler/setup"

require "tweetstream"
require "resque"
require "resque/tasks"

require File.dirname(__FILE__) + "/twitterbot/push_tweet"

STDOUT.sync = true

#-- Stream search results from twitter --#

task "tweetstream:stream" => "queue:environment" do
  puts "hi"
  
  TweetStream.configure do |config|
    config.consumer_key       = '1SlFlzJzjwFb8Hu0Xg7gQ'
    config.consumer_secret    = 'd98spifmqqD4PDC9A228jH6qfNDNmxPrhaM7eEdR7A8'
    config.oauth_token        = '5939272-q771BC0UaTMTKUICrBRn5ueJOwvxvuENox1YyEqoyM'
    config.oauth_token_secret = 'CzZYGuU1xwOROkYT8X2v3rlpLjaNZFJHRFjQDXQp5w'
    config.auth_method        = :oauth
  end

  # Use 'track' to track a list of single-word keywords
  TweetStream::Client.new.track('WorldSeries') do |status|
    puts "QUEUING: #{status.text}"
    tweet = {
      :status => status.text
    }
    Resque.enqueue(PushTweet, tweet)
  end
end

namespace :queue do

  task :environment do
    puts "doing env thing"
    if(ENV['REDISTOGO_URL'])
      require File.dirname(__FILE__) + "/config/resque"
    end
  end

  task :clear do
    [:tweets_queue].each do |name|
      Resque.redis.del "queue:#{name}"
    end
  end
end