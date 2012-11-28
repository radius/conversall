#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require "rubygems"
require "bundler/setup"

require "tweetstream"
require "resque"
require "resque/tasks"

CampaignManager::Application.load_tasks

require File.dirname(__FILE__) + "/twitterbot/push_tweet"

STDOUT.sync = true


#-- Stream search results from twitter --#

task "tweetstream:stream" => :environment do
  puts "hi"
  
  TweetStream.configure do |config|
    config.consumer_key       = '1SlFlzJzjwFb8Hu0Xg7gQ'
    config.consumer_secret    = 'd98spifmqqD4PDC9A228jH6qfNDNmxPrhaM7eEdR7A8'
    config.oauth_token        = '5939272-q771BC0UaTMTKUICrBRn5ueJOwvxvuENox1YyEqoyM'
    config.oauth_token_secret = 'CzZYGuU1xwOROkYT8X2v3rlpLjaNZFJHRFjQDXQp5w'
    config.auth_method        = :oauth
  end

  # Use 'track' to track a list of single-word keywords
  tags = Trigger.select('hashtag').where({:active => true}).map! do |i| 
    i.hashtag
  end
  p tags
  TweetStream::Client.new.track('cnvrsltest') do |status|
    puts "QUEUING: #{status.text}"
    tweet = {
      :id => status.id,
      :handle => status.user.screen_name,
      :status => status.text,
      :followers_count => status.user.followers_count
    }
    Resque.enqueue(PushTweet, tweet)
  end
end

namespace :queue do

  task :environment => :environment do
    puts "doing env thing"
    if(ENV['REDISTOGO_URL'])
      puts 'loading resque config'
      require File.dirname(__FILE__) + "/config/resque"
    end
  end

  task :clear do
    [:tweets_queue].each do |name|
      Resque.redis.del "queue:#{name}"
    end
  end
end

namespace :resque do

  task :setup => :environment do
    if(ENV['REDISTOGO_URL'])
      puts 'loading resque config'
      require File.dirname(__FILE__) + "/config/resque"
    end
  end
end
