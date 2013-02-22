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

  while true
    #loop forever. client will stop if new tags come it
    EM.run do
      puts "top of EM loop"

      EM::PeriodicTimer.new(60) do
        puts "check for reset"
        if @client
          # check to see if we need to reset?
          @client.stop
        end
      end

      TweetStream.configure do |config|
        config.consumer_key       = '1SlFlzJzjwFb8Hu0Xg7gQ'
        config.consumer_secret    = 'd98spifmqqD4PDC9A228jH6qfNDNmxPrhaM7eEdR7A8'
        config.oauth_token        = '5939272-q771BC0UaTMTKUICrBRn5ueJOwvxvuENox1YyEqoyM'
        config.oauth_token_secret = 'CzZYGuU1xwOROkYT8X2v3rlpLjaNZFJHRFjQDXQp5w'
        config.auth_method        = :oauth
      end

      @client = TweetStream::Client.new

      @client.on_error do |error|
        puts error
      end

      # Use 'track' to track a list of single-word keywords
      tags = Trigger.select('hashtag').where({:active => true}).map{|i| "#" + i.hashtag}

      puts "tracking #{tags}"
      @client.track(tags) do |status|
        puts "QUEUING: #{status.text}"
        hashtags = status.hashtags.map {|h| h.to_hash[:text] }
        tweet = {
            :id => status.id,
            :handle => status.user.screen_name,
            :status => status.text,
            :followers_count => status.user.followers_count,
            :hashtags => hashtags
        }
        Resque.enqueue(PushTweet, tweet)
      end
    end
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
